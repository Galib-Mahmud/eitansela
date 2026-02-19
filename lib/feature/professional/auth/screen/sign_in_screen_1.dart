import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/route_name.dart';
import '../../../../widget/auth/custom_button.dart';
import '../../../../widget/auth/custom_text_field.dart';



class SignInScreen1 extends StatefulWidget {
  const SignInScreen1({super.key});

  @override
  _SignInScreen1State createState() => _SignInScreen1State();
}

class _SignInScreen1State extends State<SignInScreen1> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToSignUp() {
    Get.toNamed(RouteName.signup);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120.h),

                // Logo Image
                Center(
                  child: Image.asset(
                    'assets/images/auth/signin.png',
                  ),
                ),

                SizedBox(height: 20.h),

                // Welcome Text
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 24.sp,
                    color: const Color(0xFFF8C106),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Log in to discover your perfect match",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                    color: Colors.grey,
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

                SizedBox(height: 16.h),

                // Password TextField
                CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Enter Password',
                  controller: _passwordController,
                  obscureText: true,
                ),

                SizedBox(height: 16.h),

                // Forgot Password
                TextButton(
                  onPressed: () {
                    Get.toNamed(RouteName.forgetPass);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Sign In Button
                CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    Get.toNamed(RouteName.main);
                  },
                ),

                SizedBox(height: 30.h),

                // Don't have an account? Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToSignUp,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: const Color(0xFFF8C106),
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