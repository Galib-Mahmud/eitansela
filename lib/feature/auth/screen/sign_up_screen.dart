import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    // Validate passwords match
    if (_passwordController.text != _reEnterPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',

      );
      return;
    }
    print('Sign Up attempted with email: ${_emailController.text}');
    // Get.toNamed(RouteName.homeScreen);
  }

  void _navigateToLogin() {
    print('Navigate to Login screen');
    // Get.toNamed(RouteName.signIn);
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

                // Full Name TextField
                CustomTextField(
                  icon: Icons.person_outline,
                  labelText: 'Enter Full Name',
                  controller: _fullNameController,
                  keyboardType: TextInputType.name,
                ),

                SizedBox(height: 16.h),

                // Email TextField
                CustomTextField(
                  icon: Icons.email_outlined,
                  labelText: 'Enter Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 16.h),

                // Mobile Number TextField
                CustomTextField(
                  icon: Icons.phone_outlined,
                  labelText: 'Enter Mobile Number',
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 16.h),

                // Password TextField
                CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Enter Password',
                  controller: _passwordController,
                  obscureText: true,
                ),

                SizedBox(height: 16.h),

                // Re-Enter Password TextField
                CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Re Enter Password',
                  controller: _reEnterPasswordController,
                  obscureText: true,
                ),

                SizedBox(height: 30.h),

                // Sign Up Button
                CustomButton(
                  text: 'Sign Up',
                  onPressed: _signUp,
                ),

                SizedBox(height: 20.h),

                // Already have an account? Login Here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: Text(
                        "Login Here",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: Color(0xFF2CBCB6),
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