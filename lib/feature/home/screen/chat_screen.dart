import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfessionalChatScreen extends StatefulWidget {
  const ProfessionalChatScreen({super.key});

  @override
  State<ProfessionalChatScreen> createState() => _ProfessionalChatScreenState();
}

class _ProfessionalChatScreenState extends State<ProfessionalChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Hi David! Could you please share your estimated cost for this job?",
      isSentByMe: true,
      time: "10:36 AM",
      status: "Seen",
    ),
    ChatMessage(
      text: "Hi! Based on the details, the estimated cost would be ₪600. This includes service and basic materials.",
      isSentByMe: false,
      time: "10:37 AM",
    ),
    ChatMessage(
      text: "Great, let's finalize the budget. Does 350 work for you?",
      isSentByMe: true,
      time: "10:38 AM",
      status: "Delivered",
    ),
    ChatMessage(
      text: "That works for me 👍\nWhen would you be available?",
      isSentByMe: false,
      time: "10:38 AM",
    ),
    ChatMessage(
      text: "I can do it today within 45 minutes, or we can schedule a time that suits you better.",
      isSentByMe: true,
      time: "10:38 AM",
      status: "Delivered",
    ),
    ChatMessage(
      text: "Let's go with today.",
      isSentByMe: false,
      time: "10:38 AM",
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: _messageController.text.trim(),
          isSentByMe: true,
          time: "Now",
          status: "Sent",
        ));
        _messageController.clear();
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            _buildAppBar(),


            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildDateSeparator('Today');
                  return _buildMessageBubble(messages[index - 1]);
                },
              ),
            ),

            // Bottom section
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // ───────────────────── App Bar ─────────────────────────────────────
  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: const Color(0xFF212121),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 10.w),
          // Profile image
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Name + job
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'David Cohen',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Plumber • Job #2481',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFFF8C106),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────── Date Separator ──────────────────────────────
  Widget _buildDateSeparator(String date) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(
          date,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFFBDBDBD),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // ───────────────────── Message Bubble ──────────────────────────────
  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: message.isSentByMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Bubble
          Align(
            alignment:
            message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(maxWidth: 280.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: message.isSentByMe
                    ? const Color(0xFF2196F3)
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                  bottomLeft: message.isSentByMe
                      ? Radius.circular(18.r)
                      : Radius.circular(4.r),
                  bottomRight: message.isSentByMe
                      ? Radius.circular(4.r)
                      : Radius.circular(18.r),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: message.isSentByMe
                      ? Colors.white
                      : const Color(0xFF212121),
                  height: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          // Time + status
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              message.status != null
                  ? '${message.time}   • ${message.status}'
                  : message.time,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFFBDBDBD),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────── Bottom Section ──────────────────────────────
  Widget _buildBottomSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          // Input field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: const Color(0xFFBDBDBD),
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          fontSize: 18.sp,

                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Icon(
                      Icons.send_rounded,
                      color: const Color(0xFFBDBDBD),
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Divider
          Container(height: 1, color: const Color(0xFFEEEEEE)),

          SizedBox(height: 12.h),

          // Budget discussed card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  // Dollar icon
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFF8C106),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF8C106),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budget discussed',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF212121),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          "Let's confirm the location & timing.",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Confirm & Schedule button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.location);
              },
              child: Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8C106),
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Confirm & Schedule',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Warning text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Make sure price & timing are confirmed before proceeding.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF9E9E9E),
              ),
            ),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;
  final String? status;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.status,
  });
}