import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfessionalChatScreen extends StatefulWidget {
  const ProfessionalChatScreen({Key? key}) : super(key: key);

  @override
  State<ProfessionalChatScreen> createState() => _ProfessionalChatScreenState();
}

class _ProfessionalChatScreenState extends State<ProfessionalChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Sample messages
  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Hi David! Could you please share your estimated cost for this job?",
      isSentByMe: true,
      time: "10:45 AM",
      status: "Sent",
    ),
    ChatMessage(
      text: "Hi! Based on the details, the estimated cost would be ₪600. This includes service and basic materials.",
      isSentByMe: false,
      time: "10:47 AM",
    ),
    ChatMessage(
      text: "Great, let's finalize the budget. Does 350 work for you?",
      isSentByMe: true,
      time: "10:50 AM",
      status: "Delivered",
    ),
    ChatMessage(
      text: "That works for me 👍\nWhen would you be available?",
      isSentByMe: false,
      time: "10:50 AM",
    ),
    ChatMessage(
      text: "I can do it today within 45 minutes, or we can schedule a time that suits you better.",
      isSentByMe: false,
      time: "10:51 AM",
      status: "Delivered",
    ),
    ChatMessage(
      text: "Let's go with today.",
      isSentByMe: true,
      time: "10:52 AM",
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
        messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isSentByMe: true,
            time: "Now",
            status: "Sent",
          ),
        );
        _messageController.clear();
      });
      // Auto scroll to bottom
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            // Profile Image
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // Name and ID
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'David Cohen',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  Text(
                    'Plumber - Joe 424433',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF00B4A8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat Messages (Scrollable)
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: messages.length + 1, // +1 for date separator
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildDateSeparator('Today');
                }
                final message = messages[index - 1];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Bottom Section - Fixed
          Container(
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
                // Message Input Field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      // Attachment Icon
                      GestureDetector(
                        onTap: () {
                          // Handle attachment
                        },
                        child: Icon(
                          Icons.image_outlined,
                          color: const Color(0xFF9E9E9E),
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Text Input
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  hintText: 'Type a message...',
                                  hintStyle: TextStyle(
                                    fontSize: 18.sp,

                                  ),

                                  isDense: true,

                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Send Button
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Icon(
                          Icons.send,
                          color: const Color(0xFF00B4A8),
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  height: 1,
                  color: const Color(0xFFE0E0E0),
                ),

                // Budget Discussed Section
                Container(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F7F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: const Color(0xFF00B4A8),
                          size: 20.sp,
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
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF212121),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Let's confirm the location & timing.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF757575),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Confirm & Schedule Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to schedule confirmation
                      Get.toNamed('/schedule-confirmation');
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B4A8),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20.sp,
                          ),
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

                // Warning Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Text(
                    'Make sure price & timing are confirmed before proceeding',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String date) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          date,
          style: TextStyle(
            fontSize: 11.sp,
            color: const Color(0xFF757575),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment:
        message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isSentByMe) ...[
                // Professional's profile image
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile/profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              // Message Bubble
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: message.isSentByMe
                        ? const Color(0xFF00B4A8)
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: message.isSentByMe
                          ? Radius.circular(16.r)
                          : Radius.circular(4.r),
                      bottomRight: message.isSentByMe
                          ? Radius.circular(4.r)
                          : Radius.circular(16.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: message.isSentByMe ? Colors.white : const Color(0xFF212121),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          // Time and Status
          Padding(
            padding: message.isSentByMe
                ? EdgeInsets.only(right: 8.w)
                : EdgeInsets.only(left: 32.w),
            child: Text(
              message.status != null
                  ? '${message.time} · ${message.status}'
                  : message.time,
              style: TextStyle(
                fontSize: 10.sp,
                color: const Color(0xFF9E9E9E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Message Model
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
