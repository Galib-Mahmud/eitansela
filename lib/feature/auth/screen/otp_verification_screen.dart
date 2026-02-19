import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    this.email = 'contact@dscode..com',
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _otpControllers.map((c) => c.text).join();

  void _verifyCode() {
    if (_otpCode.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter the complete 6-digit code',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    print('Verifying OTP: $_otpCode');
    // Get.toNamed(RouteName.passwordReset);
  }

  void _resendEmail() {
    print('Resend email to: ${widget.email}');
    Get.snackbar(
      'Success',
      'Verification code sent again',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _onKeyPressed(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _otpControllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),

                // Back button
                CustomBackButton(),

                SizedBox(height: 16.h),

                // Logo Image
                Center(
                  child: Image.asset(
                    'assets/images/auth/signin.png',
                  ),
                ),

                SizedBox(height: 20.h),

                // Check your email Text
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Check your email",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          color: Color(0xFFF8C106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "We sent a code to ${widget.email}. Enter 6\ndigit code that mentioned in the email",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45.w,
                      height: 50.h,
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (event) => _onKeyPressed(event, index),
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: Color(0xFFF8C106),
                                width: 2,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) => _onOtpChanged(value, index),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 30.h),

                // Verify Code Button
                CustomButton(
                  text: 'Verify Code',
                  onPressed: () {
                    Get.toNamed(RouteName.resetPass);
                  },
                ),

                SizedBox(height: 20.h),

                // Haven't got the email yet? Resend email
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Haven't got the email yet? ",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: _resendEmail,
                      child: Text(
                        "Resend email",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: Color(0xFFF8C106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}