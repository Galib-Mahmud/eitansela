// lib/features/professional/activejob/controller/active_job_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/endpoint/api_client.dart';
import '../../../../../core/endpoint/api_endpoint.dart';
import '../../../../../core/local_storage/user_info.dart';
import '../../../../customer/screen/chat_screen.dart';
import '../../../../customer/screen/home/controllers/chat_controller.dart';

// ── Progress Step Models ───────────────────────────────────────────
enum JobProgressStatus { pending, active, completed }

class JobProgressStep {
  final int number;
  final String label;
  final String? subtitle;
  final JobProgressStatus status;

  const JobProgressStep({
    required this.number,
    required this.label,
    this.subtitle,
    required this.status,
  });
}

// ── Controller ─────────────────────────────────────────────────────
class ActiveJobController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);
  final ImagePicker _picker = ImagePicker();

  // ── Job ID ────────────────────────────────────────────────────────
  int get jobId => (Get.arguments?['jobId'] as int?) ?? 0;

  // ── Loading ───────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;

  // ── Job Info ──────────────────────────────────────────────────────
  final RxString jobStatus = 'Pending'.obs;
  final RxString jobStatusCode = 'PENDING'.obs;
  final RxString clientName = ''.obs;
  final RxString clientAddress = ''.obs;
  final RxString clientImage = ''.obs;
  final RxString serviceName = ''.obs;
  final RxString serviceIcon = ''.obs;

  // ── Job Details ───────────────────────────────────────────────────
  final RxString detectedIssue = ''.obs;
  final RxString severity = 'Normal'.obs;
  final RxString estPriceMin = '0'.obs;
  final RxString estPriceMax = '0'.obs;
  final RxString estCurrency = 'EUR'.obs;
  final RxString priceFeedback = ''.obs;

  // ── Timeline ──────────────────────────────────────────────────────
  final Rx<DateTime?> timeRequestReceived = Rx(null);
  final Rx<DateTime?> timeOnTheWay = Rx(null);
  final Rx<DateTime?> timeInProgress = Rx(null);
  final Rx<DateTime?> timeCompleted = Rx(null);

  // ── Bill submission ────────────────────────────────────────────────
  // Using RxString for path so Obx re-renders on change
  final RxString billImagePath = ''.obs;
  final RxString beforePhotoPath = ''.obs;
  final RxString afterPhotoPath = ''.obs;

  File? get billImageFile => billImagePath.value.isNotEmpty ? File(billImagePath.value) : null;
  File? get beforePhotoFile => beforePhotoPath.value.isNotEmpty ? File(beforePhotoPath.value) : null;
  File? get afterPhotoFile => afterPhotoPath.value.isNotEmpty ? File(afterPhotoPath.value) : null;

  // ── Progress Steps (reactive list) ───────────────────────────────
  final RxList<JobProgressStep> progressSteps = <JobProgressStep>[].obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // ── Client Info ───────────────────────────────────────────────
    clientName.value    = _str(args['customer_name'], fallback: 'Customer');
    clientAddress.value = _str(args['address']);
    // customer_photo is null in the API — keep as empty string; UI handles it
    clientImage.value   = _str(args['customer_photo']);

    // ── Service / Issue ────────────────────────────────────────────
    // API returns service_name as "" — fall back to service_details.name_en
    final serviceDetails = _asMap(args['service_details']);
    final svcName = _str(args['service_name']);
    detectedIssue.value = svcName.isNotEmpty
        ? svcName
        : _str(serviceDetails['name_en'], fallback: 'Service');

    serviceName.value = detectedIssue.value;
    serviceIcon.value = _str(args['service_icon']).isNotEmpty
        ? _str(args['service_icon'])
        : _str(serviceDetails['icon']);

    // ── Priority ───────────────────────────────────────────────────
    severity.value = args['mark_as_priority'] == true ? 'Priority' : 'Normal';

    // ── AI Cost ────────────────────────────────────────────────────
    // API sends: { "min": 1200, "max": 3500, "currency": "EUR" }
    final aiCostMap = _asMap(args['ai_cost']);
    if (aiCostMap.isNotEmpty) {
      estPriceMin.value = aiCostMap['min']?.toString() ?? '0';
      estPriceMax.value = aiCostMap['max']?.toString() ?? '0';
      estCurrency.value = _str(aiCostMap['currency'], fallback: 'EUR');
    } else {
      // Fallback: pre-split keys passed manually
      estPriceMin.value = args['ai_cost_min']?.toString() ?? '0';
      estPriceMax.value = args['ai_cost_max']?.toString() ?? '0';
      estCurrency.value = _str(args['ai_cost_currency'], fallback: 'EUR');
    }

    // ── Timeline ──────────────────────────────────────────────────
    _applyTimeline(_asMap(args['timeline']));

    // ── Status ────────────────────────────────────────────────────
    _applyStatus(
      _str(args['status'], fallback: 'PENDING'),
      _str(args['status_display'], fallback: 'Pending'),
    );

    _rebuildSteps();
    _acceptLead();
  }

  // ── Safe string extractor ─────────────────────────────────────────
  /// Returns a String from any dynamic value.
  /// - null        → fallback (default '')
  /// - String      → as-is
  /// - anything else (Map, int, bool, …) → .toString(), or fallback if empty
  String _str(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    if (value is String) return value.isEmpty ? fallback : value;
    // Maps, ints, bools, etc. — convert but don't use as a string field value
    // (a Map stringified looks like "{...}" which is wrong for display)
    if (value is Map || value is List) return fallback;
    final s = value.toString();
    return s.isEmpty ? fallback : s;
  }

  // ── Safe map extractor ────────────────────────────────────────────
  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return {};
  }

  // ─────────────────────────────────────────────────────────────────
  // STEP 1 — Accept Lead
  // POST /services/requests/{id}/respond/   body: { "action": "accept" }
  // ─────────────────────────────────────────────────────────────────
  Future<void> _acceptLead() async {
    if (jobId == 0) return;
    try {
      final res = await _apiClient.post(
        ApiEndpoint.proRequestRespond(jobId),
        body: {'action': 'accept'},
        requiresAuth: true,
      );
      print('✅ [ACCEPT] ${res['message']}');
    } catch (e) {
      // "Already accepted" is fine — server returns 200 with message
      print('⚠️ [ACCEPT] $e');
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // STEP 2 — Advance Status
  // POST /services/requests/{id}/advance-status/
  // body: { "status": "ON_THE_WAY" | "IN_PROGRESS" }
  // ─────────────────────────────────────────────────────────────────
  Future<void> advanceStatus() async {
    final nextStatus = _nextStatusCode();
    if (nextStatus == null) return;

    try {
      isActionLoading.value = true;
      print('🚀 [ADVANCE] → $nextStatus');

      final res = await _apiClient.post(
        ApiEndpoint.proAdvanceStatus(jobId),
        body: {'status': nextStatus},
        requiresAuth: true,
      );

      final newCode = (res['status'] as String?) ?? nextStatus;
      final newDisplay = (res['status_display'] as String?) ?? nextStatus;
      _applyStatus(newCode, newDisplay);
      _applyTimeline(_asMap(res['timeline']));
      _rebuildSteps();

      print('✅ [ADVANCE] Now: ${jobStatusCode.value}');
    } on HttpException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('❌ [ADVANCE] $e');
      Get.snackbar('Error', 'Something went wrong.');
    } finally {
      isActionLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // STEP 3 — Submit Bill
  // POST /services/requests/{id}/submit-bill/
  // Multipart: bill_image, before_photo, after_photo
  // ─────────────────────────────────────────────────────────────────
  Future<void> submitBill() async {
    if (billImageFile == null || beforePhotoFile == null || afterPhotoFile == null) {
      Get.snackbar(
        'Missing Photos',
        'Please attach the bill image, before photo, and after photo.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isActionLoading.value = true;
      print('📄 [BILL] Submitting...');

      final res = await _apiClient.multipart(
        ApiEndpoint.proSubmitBill(jobId),
        method: 'POST',
        fields: {},
        files: {
          'bill_image': billImageFile!,
          'before_photo': beforePhotoFile!,
          'after_photo': afterPhotoFile!,
        },
        requiresAuth: true,
      );

      final newCode = (res['status'] as String?) ?? 'COMPLETED';
      _applyStatus(newCode, 'Completed');
      _rebuildSteps();

      Get.snackbar(
        'Done',
        (res['message'] as String?) ?? 'Job marked as Completed.',
        backgroundColor: const Color(0xFF43A047),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on HttpException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('❌ [BILL] $e');
      Get.snackbar('Error', 'Failed to submit bill.');
    } finally {
      isActionLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // IMAGE PICKERS
  // Using RxString paths so Obx widgets rebuild when a photo is picked
  // ─────────────────────────────────────────────────────────────────
  Future<void> pickBillImage() async {
    final path = await _pickFromSource(ImageSource.gallery);
    if (path != null) billImagePath.value = path;
  }

  Future<void> pickBeforePhoto() async {
    final path = await _pickFromSource(ImageSource.gallery);
    if (path != null) beforePhotoPath.value = path;
  }

  Future<void> pickAfterPhoto() async {
    final path = await _pickFromSource(ImageSource.gallery);
    if (path != null) afterPhotoPath.value = path;
  }

  Future<String?> _pickFromSource(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 80);
      return picked?.path;
    } catch (e) {
      Get.snackbar('Error', 'Could not pick image.');
      return null;
    }
  }

  /// Called by the view when user wants to pick from camera
  Future<void> pickBillImageFromCamera() async {
    final path = await _pickFromSource(ImageSource.camera);
    if (path != null) billImagePath.value = path;
  }

  Future<void> pickBeforePhotoFromCamera() async {
    final path = await _pickFromSource(ImageSource.camera);
    if (path != null) beforePhotoPath.value = path;
  }

  Future<void> pickAfterPhotoFromCamera() async {
    final path = await _pickFromSource(ImageSource.camera);
    if (path != null) afterPhotoPath.value = path;
  }

  // ─────────────────────────────────────────────────────────────────
  // PRICE FEEDBACK
  // ─────────────────────────────────────────────────────────────────
  void submitGoodEstimation() => priceFeedback.value = 'good';
  void submitBadEstimation() => priceFeedback.value = 'bad';

  // ─────────────────────────────────────────────────────────────────
  // CHAT
  // ─────────────────────────────────────────────────────────────────
  void openChat() {
    if (Get.isRegistered<ProfessionalChatController>()) {
      Get.delete<ProfessionalChatController>(force: true);
    }
    Get.put(ProfessionalChatController());

    Get.to(
          () => const ProfessionalChatScreen(),
      arguments: {
        'requestId'  : jobId,
        'clientName' : clientName.value,
        'jobLabel'   : '${serviceName.value} • Job #$jobId',
        'clientPhoto': clientImage.value,
        'myName'     : UserInfo.getFullNameSync() ?? '',  // ✅
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────────────────────────
  String? _nextStatusCode() {
    switch (jobStatusCode.value) {
      case 'PENDING':
      case 'CONFIRMED':
        return 'ON_THE_WAY';
      case 'ON_THE_WAY':
        return 'IN_PROGRESS';
      case 'IN_PROGRESS':
        return null; // → submit bill instead
      default:
        return null;
    }
  }

  void _applyStatus(String code, String display) {
    jobStatusCode.value = code;
    jobStatus.value = display;
  }

  void _applyTimeline(Map<String, dynamic> timeline) {
    // timeline values are ISO strings or null — _parseDate handles both
    timeRequestReceived.value = _parseDate(timeline['request_received']);
    timeOnTheWay.value = _parseDate(timeline['on_the_way']);
    timeInProgress.value = _parseDate(timeline['in_progress']);
    timeCompleted.value = _parseDate(timeline['completed']);
  }

  DateTime? _parseDate(dynamic val) =>
      val != null ? DateTime.tryParse(val.toString()) : null;

  /// Rebuilds the reactive progressSteps list — call after any status change.
  void _rebuildSteps() {
    progressSteps.assignAll(_buildSteps());
  }

  List<JobProgressStep> _buildSteps() {
    const order = ['CONFIRMED', 'ON_THE_WAY', 'IN_PROGRESS', 'COMPLETED'];
    final code = jobStatusCode.value;
    final currentIdx = order.indexOf(code == 'PENDING' ? 'CONFIRMED' : code);

    JobProgressStatus stepStatus(String step) {
      final stepIdx = order.indexOf(step);
      if (stepIdx < currentIdx) return JobProgressStatus.completed;
      if (stepIdx == currentIdx) return JobProgressStatus.active;
      return JobProgressStatus.pending;
    }

    return [
      JobProgressStep(
        number: 1,
        label: 'Request Received',
        subtitle: timeRequestReceived.value != null ? _fmt(timeRequestReceived.value!) : null,
        status: JobProgressStatus.completed, // always completed once we're on this screen
      ),
      JobProgressStep(
        number: 2,
        label: 'On The Way',
        subtitle: timeOnTheWay.value != null ? _fmt(timeOnTheWay.value!) : null,
        status: stepStatus('ON_THE_WAY'),
      ),
      JobProgressStep(
        number: 3,
        label: 'In Progress',
        subtitle: timeInProgress.value != null ? _fmt(timeInProgress.value!) : null,
        status: stepStatus('IN_PROGRESS'),
      ),
      JobProgressStep(
        number: 4,
        label: 'Completed',
        subtitle: timeCompleted.value != null ? _fmt(timeCompleted.value!) : null,
        status: stepStatus('COMPLETED'),
      ),
    ];
  }

  String _fmt(DateTime dt) {
    final l = dt.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}'
        ' · ${l.day.toString().padLeft(2, '0')}.${l.month.toString().padLeft(2, '0')}';
  }

  // ── Button label & icon based on current status ───────────────────
  String get bottomButtonLabel {
    switch (jobStatusCode.value) {
      case 'PENDING':
      case 'CONFIRMED':
        return "I'm On The Way";
      case 'ON_THE_WAY':
        return 'Start Job';
      case 'IN_PROGRESS':
        return 'Submit Bill';
      case 'COMPLETED':
        return 'Job Completed ✓';
      default:
        return 'Next Step';
    }
  }

  IconData get bottomButtonIcon {
    switch (jobStatusCode.value) {
      case 'PENDING':
      case 'CONFIRMED':
        return Icons.directions_car_outlined;
      case 'ON_THE_WAY':
        return Icons.build_outlined;
      case 'IN_PROGRESS':
        return Icons.receipt_long_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }

  bool get isJobCompleted => jobStatusCode.value == 'COMPLETED';
  bool get isInProgress => jobStatusCode.value == 'IN_PROGRESS';
}