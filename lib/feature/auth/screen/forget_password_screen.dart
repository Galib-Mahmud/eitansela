import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    print('Reset password for email: ${_emailController.text}');
    // Add your password reset logic here
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

                // Forgot Password Text
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Forgot password",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          color: Color(0xFFF8C106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Please enter your email to reset the password",
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

                // Email TextField
                CustomTextField(
                  icon: Icons.email_outlined,
                  labelText: 'Enter Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 30.h),

                // Reset Password Button
                CustomButton(
                  text: 'Get OTP',
                  onPressed: () {
                    Get.toNamed(RouteName.otpVerification);
                  },
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