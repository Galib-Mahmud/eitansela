import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _newPasswordController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    if (_newPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your new password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_newPasswordController.text != _reEnterPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_newPasswordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print('Password updated successfully');
    // Get.toNamed(RouteName.passwordResetSuccess);
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

                // Password reset Text
                Center(
                  child: Text(
                    "Password reset",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 24.sp,
                      color: Color(0xFF2CBCB6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // New Password TextField
                CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Enter your new password',
                  controller: _newPasswordController,
                  obscureText: true,
                ),

                SizedBox(height: 16.h),

                // Re-Enter New Password TextField
                CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Re- Enter new password',
                  controller: _reEnterPasswordController,
                  obscureText: true,
                ),

                SizedBox(height: 30.h),

                // Update Password Button
                CustomButton(
                  text: 'Update Password',
                  onPressed: _updatePassword,
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