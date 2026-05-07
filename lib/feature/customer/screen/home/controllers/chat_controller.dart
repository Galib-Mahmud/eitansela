// lib/features/professional/chat/controller/professional_chat_controller.dart

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

import '../../../../../core/endpoint/api_client.dart';
import '../../../../../core/endpoint/api_endpoint.dart';
import '../../../../../core/local_storage/user_info.dart';

// ── Model ──────────────────────────────────────────────────────────
class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;
  final String? status;
  final String? sender;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.status,
    this.sender,
  });

  /// From REST history endpoint GET /api/requests/{id}/messages/
  factory ChatMessage.fromJson(Map<String, dynamic> json, String myName) {
    final sender   = (json['sender_name'] ?? json['sender'] ?? '') as String;
    final sentByMe = sender == myName;
    final ts       = json['timestamp'] as String? ?? '';
    String time    = '';
    if (ts.isNotEmpty) {
      try {
        final dt = DateTime.parse(ts).toLocal();
        time = '${dt.hour.toString().padLeft(2, '0')}:'
            '${dt.minute.toString().padLeft(2, '0')}';
      } catch (_) {
        time = ts;
      }
    }
    return ChatMessage(
      text      : (json['message'] ?? json['text'] ?? '') as String,
      isSentByMe: sentByMe,
      time      : time,
      sender    : sender,
    );
  }

  /// From WebSocket broadcast: { "message": "...", "sender": "Arman Hosen" }
  /// sender = full_name from backend
  factory ChatMessage.fromWs(Map<String, dynamic> json, String myFullName) {
    final sender   = (json['sender'] ?? '') as String;
    final sentByMe = sender == myFullName;
    final now      = TimeOfDay.now();
    final time     = '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';
    return ChatMessage(
      text      : (json['message'] ?? '') as String,
      isSentByMe: sentByMe,
      time      : time,
      sender    : sender,
      status    : sentByMe ? 'Sent' : null,
    );
  }
}

// ── Controller ─────────────────────────────────────────────────────
class ProfessionalChatController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  // ── Passed via Get.arguments ───────────────────────────────────────
  late final int    requestId;
  late final String clientName;
  late final String jobLabel;
  late final String clientPhoto;

  // myFullName must match the "sender" field the backend returns.
  // Pass the logged-in user's full_name in Get.arguments['myName'].
  String _myFullName = '';

  // ── Reactive state ─────────────────────────────────────────────────
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading             = false.obs;
  final RxBool isConnected           = false.obs;
  final RxBool isSending             = false.obs;

  final TextEditingController textController   = TextEditingController();
  final ScrollController      scrollController = ScrollController();

  // ── WebSocket internals ────────────────────────────────────────────
  WebSocketChannel? _channel;
  StreamSubscription? _wsSub;
  bool _disposed   = false;
  int  _retryCount = 0;
  static const int _maxRetries = 8;

  // Messages typed before socket is confirmed open
  final List<String> _pendingQueue = [];

  @override
  void onInit() {
    super.onInit();
    final args   = Get.arguments as Map<String, dynamic>? ?? {};
    requestId    = (args['requestId']   as int?)    ?? 0;
    clientName   = (args['clientName']  as String?) ?? 'Customer';
    jobLabel     = (args['jobLabel']    as String?) ?? 'Job';
    clientPhoto  = (args['clientPhoto'] as String?) ?? '';
    _myFullName  = (args['myName']      as String?) ?? '';

    _fetchHistory();
    _connectWebSocket();
  }

  @override
  void onClose() {
    _disposed = true;
    _wsSub?.cancel();
    try {
      _channel?.sink.close(ws_status.goingAway);
    } catch (_) {}
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // ─────────────────────────────────────────────────────────────────
  // REST: fetch message history
  // GET /api/requests/{id}/messages/
  // ─────────────────────────────────────────────────────────────────
  Future<void> fetchHistory() => _fetchHistory();

  Future<void> _fetchHistory() async {
    if (requestId == 0) return;
    try {
      isLoading.value = true;
      print('💬 [CHAT] Fetching history for request $requestId');

      final res = await _apiClient.get(
        ApiEndpoint.chatMessages(requestId),
        requiresAuth: true,
      );

      final List<dynamic> raw =
      res is List ? res : (res['results'] as List? ?? []);

      messages.assignAll(
        raw.map((e) => ChatMessage.fromJson(
            Map<String, dynamic>.from(e as Map), _myFullName)),
      );
      _scrollToBottom();
    } catch (e) {
      print('❌ [CHAT HISTORY] $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // WebSocket: connect
  //
  // Uses WebSocketChannel.connect() exactly as the backend docs say.
  // URL format: ws://<domain>/ws/chat/<id>/?token=<jwt>
  // Do NOT use custom headers — token goes in query string only.
  // ─────────────────────────────────────────────────────────────────
  void _connectWebSocket() {
    if (requestId == 0 || _disposed) return;

    try {
      // Read the JWT the same way ApiClient does — synchronous, no async gap
      final token = UserInfo.getAccessTokenSync() ?? '';
      if (token.isEmpty) {
        print('⚠️ [WS] No token available — aborting connection');
        return;
      }

      // Clean up any previous channel
      _wsSub?.cancel();
      try { _channel?.sink.close(); } catch (_) {}

      // Build WS URI exactly as documented
      final wsUri = Uri.parse(
        '${ApiEndpoint.chatWebSocket(requestId)}?token=$token',
      );
      print('🔌 [WS] Connecting → $wsUri');

      // WebSocketChannel.connect() as per official Flutter WS docs
      _channel = WebSocketChannel.connect(wsUri);

      // Attach listener immediately — the channel is open once connect() returns
      _wsSub = _channel!.stream.listen(
        _onWsMessage,
        onError      : _onWsError,
        onDone       : _onWsDone,
        cancelOnError: false,
      );

      // Mark connected and flush any queued messages
      isConnected.value = true;
      _retryCount       = 0;
      print('✅ [WS] Connected to request $requestId');
      _flushPendingQueue();

    } catch (e) {
      print('❌ [WS CONNECT] $e');
      isConnected.value = false;
      _scheduleReconnect();
    }
  }

  // ── Incoming message ──────────────────────────────────────────────
  // Format: { "message": "Hello", "sender": "Arman Hosen" }
  void _onWsMessage(dynamic raw) {
    try {
      final data = jsonDecode(raw as String) as Map<String, dynamic>;
      print('📨 [WS] Received: $data');

      final msg = ChatMessage.fromWs(data, _myFullName);

      // Don't duplicate our own optimistic messages
      if (!msg.isSentByMe) {
        messages.add(msg);
        _scrollToBottom();
      }
    } catch (e) {
      print('❌ [WS PARSE] $e');
    }
  }

  void _onWsError(dynamic error) {
    print('❌ [WS ERROR] $error');
    isConnected.value = false;
    _scheduleReconnect();
  }

  void _onWsDone() {
    print('🔌 [WS] Connection closed');
    isConnected.value = false;
    _scheduleReconnect();
  }

  // Exponential back-off: 2s → 4s → 6s … capped at 30s
  void _scheduleReconnect() {
    if (_disposed || _retryCount >= _maxRetries) return;
    _retryCount++;
    final delay = Duration(seconds: (_retryCount * 2).clamp(2, 30));
    print('🔄 [WS] Retry #$_retryCount in ${delay.inSeconds}s');
    Future.delayed(delay, () {
      if (!_disposed) _connectWebSocket();
    });
  }

  // ─────────────────────────────────────────────────────────────────
  // Send message
  // Payload: { "message": "..." }
  // ─────────────────────────────────────────────────────────────────
  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // Optimistic UI — add instantly so the user sees their message
    final now  = TimeOfDay.now();
    final time = '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';
    messages.add(ChatMessage(
      text      : text,
      isSentByMe: true,
      time      : time,
      status    : 'Sent',
      sender    : _myFullName,
    ));
    textController.clear();
    _scrollToBottom();

    if (isConnected.value && _channel != null) {
      _sendViaSocket(text);
    } else {
      // Queue it — will be flushed automatically on reconnect
      print('⏳ [WS] Not connected — queuing: "$text"');
      _pendingQueue.add(text);
      _connectWebSocket(); // attempt immediate reconnect
    }
  }

  void _sendViaSocket(String text) {
    try {
      _channel!.sink.add(jsonEncode({'message': text}));
      print('📤 [WS] Sent: $text');
    } catch (e) {
      print('❌ [WS SEND] $e');
      _pendingQueue.insert(0, text);
      isConnected.value = false;
      _scheduleReconnect();
    }
  }

  void _flushPendingQueue() {
    if (_pendingQueue.isEmpty) return;
    print('📬 [WS] Flushing ${_pendingQueue.length} queued message(s)');
    final copy = List<String>.from(_pendingQueue);
    _pendingQueue.clear();
    for (final text in copy) {
      _sendViaSocket(text);
    }
  }

  // ── Scroll to bottom ───────────────────────────────────────────────
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.position.hasContentDimensions) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve   : Curves.easeOut,
        );
      }
    });
  }
}