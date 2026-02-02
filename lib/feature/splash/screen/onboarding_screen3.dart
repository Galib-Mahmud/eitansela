import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding3Screen extends StatefulWidget {
  const Onboarding3Screen({Key? key}) : super(key: key);

  @override
  State<Onboarding3Screen> createState() => _Onboarding3ScreenState();
}

class _Onboarding3ScreenState extends State<Onboarding3Screen> {
  String selectedRole = 'Customer'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    // Illustration
                    Container(
                      width: 280.w,
                      height: 280.w,
                      child: Image.asset(
                        'assets/images/splash/3.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Title
                    Text(
                      'Choose your role',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Description
                    Text(
                      'Tell us how you\'ll use FixNow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Customer option
                    _buildRoleCard(
                      title: 'Customer',
                      description: 'Book trusted home services',
                      isSelected: selectedRole == 'Customer',
                      onTap: () {
                        setState(() {
                          selectedRole = 'Customer';
                        });
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Professional option
                    _buildRoleCard(
                      title: 'Professional',
                      description: 'Offer services & get jobs',
                      isSelected: selectedRole == 'Professional',
                      onTap: () {
                        setState(() {
                          selectedRole = 'Professional';
                        });
                      },
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Get Started button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    // You can pass the selected role to the main screen if needed
                    Get.offAllNamed('/main', arguments: {'role': selectedRole});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B4A8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00B4A8)
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF00B4A8)
                      : const Color(0xFFE0E0E0),
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xFF00B4A8)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16.sp,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}