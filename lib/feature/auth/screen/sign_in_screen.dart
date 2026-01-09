import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

/// Reusable custom back button

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    print('Login attempted with email: ${_emailController.text}');
  }

  void _navigateToSignUp() {
    print('Navigate to Sign Up screen');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                CustomBackButton(), // Back button at top-left
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/images/splash/signin.png',
                    width: 200.w,
                    height: 200.h,

                    fit: BoxFit.contain,
                  ),
                ),

                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Log in to discover your perfect match",
                        style: TextStyle(

                          fontFamily: "Inter",
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                CustomTextField(
                  icon: Icons.email,
                  labelText: 'Enter Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Enter Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Get.toNamed(RouteName.resetPass);
                      },
                      child: const Text('Forgot Password?',style: TextStyle(color: Color(0xFF555555)),),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    // Get.toNamed(RouteName.homeScreen);
                  },
                ),

                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    // Get.toNamed(RouteName.signup);
                  },
                ),
                SizedBox(height: 20.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}