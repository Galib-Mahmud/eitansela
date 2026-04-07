// lib/feature/auth/screens/sign_up_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AuthController.to;
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

                SizedBox(height: 30.h),

                // Logo Image
                Center(
                  child: Image.asset(
                    'assets/images/auth/signin.png',
                  ),
                ),

                SizedBox(height: 30.h),

                // Full Name TextField
                CustomTextField(
                  icon: Icons.person_outline,
                  labelText: 'Enter Full Name',
                  controller: c.fullNameController,
                  keyboardType: TextInputType.name,
                ),

                SizedBox(height: 16.h),

                // Email TextField
                CustomTextField(
                  icon: Icons.email_outlined,
                  labelText: 'Enter Email Address',
                  controller: c.signUpEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 16.h),

                // Mobile Number TextField
                CustomTextField(
                  icon: Icons.phone_outlined,
                  labelText: 'Enter Mobile Number',
                  controller: c.phoneController,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 16.h),

                // Password TextField
                // Password Field
                Obx(() => CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Enter Password',
                  controller: c.signUpPasswordController,
                  obscureText: !c.isSignUpPasswordVisible.value,
                  suffixIcon: GestureDetector(
                    onTap: c.toggleSignUpPasswordVisibility,
                    child: Icon(
                      c.isSignUpPasswordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFFBDBDBD),
                      size: 20.sp,
                    ),
                  ),
                )),

                SizedBox(height: 16.h),

// Re-Enter Password Field
                Obx(() => CustomTextField(
                  icon: Icons.lock_outline,
                  labelText: 'Re Enter Password',
                  controller: c.signUpRePasswordController,
                  obscureText: !c.isSignUpRePasswordVisible.value,
                  suffixIcon: GestureDetector(
                    onTap: c.toggleSignUpRePasswordVisibility,
                    child: Icon(
                      c.isSignUpRePasswordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFFBDBDBD),
                      size: 20.sp,
                    ),
                  ),
                )),
                SizedBox(height: 24.h),

                // ── Register As label ─────────────────────────────
                Text(
                  'Register As',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF424242),
                  ),
                ),

                SizedBox(height: 12.h),

                // ── Role Selection ────────────────────────────────
                Obx(() => Row(
                  children: [
                    Expanded(
                      child: _RoleCard(
                        label: 'Provider',
                        icon: Icons.handyman_outlined,
                        isSelected: c.selectedRole.value == 'PROVIDER',
                        onTap: () => c.selectRole('PROVIDER'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _RoleCard(
                        label: 'Customer',
                        icon: Icons.person_outline,
                        isSelected: c.selectedRole.value == 'CUSTOMER',
                        onTap: () => c.selectRole('CUSTOMER'),
                      ),
                    ),
                  ],
                )),

                SizedBox(height: 30.h),

                // Sign Up Button
                Obx(() => CustomButton(
                  text: c.isLoading.value ? 'Signing Up...' : 'Sign Up',
                  onPressed: c.isLoading.value ? null : () => c.register(),
                )),

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
                      onTap: () => Get.back(),
                      child: Text(
                        "Login Here",
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

// ─── Role Card Widget ─────────────────────────────────────────────
class _RoleCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 70.h,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF8C106).withOpacity(0.12)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFF8C106)
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: isSelected
                  ? const Color(0xFFF8C106)
                  : Colors.grey.shade500,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14.sp,
                fontWeight:
                isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFFF8C106)
                    : Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 4.w),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 16.sp,
                color: const Color(0xFFF8C106),
              ),
          ],
        ),
      ),
    );
  }
}