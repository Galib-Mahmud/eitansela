import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  void _goToLogin() {
    print('Navigate to Login screen');
    // Get.offAllNamed(RouteName.signIn);
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

                SizedBox(height: 40.h),

                // Logo Image
                Center(
                  child: Image.asset(
                    'assets/images/auth/signin.png',
                  ),
                ),

                SizedBox(height: 20.h),

                // Password Reset successful Text
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Password Reset successful",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          color: Color(0xFFF8C106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "You've successfully reset your password.",
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

                // Update Password / Back to Login Button
                CustomButton(
                  text: 'Sign in',
                  onPressed: () {
                    Get.toNamed(RouteName.signin);
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