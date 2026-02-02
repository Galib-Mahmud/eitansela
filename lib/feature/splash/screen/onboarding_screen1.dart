import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h),
                child: TextButton(
                  onPressed: () {
                    Get.offAllNamed('/main');
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    // Illustration
                    Container(

                      child: Image.asset(
                        'assets/images/splash/1.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Title
                    Text(
                      'FixNow – Smart Home Repair,\nPowered by AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Description
                    Text(
                      'Snap a photo, diagnose instantly, and get the\nright expert fast.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Page indicators
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Active indicator
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 24.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B4A8),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  // Inactive indicator
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),

            // Next button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/onboarding2');
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
                    'Next',
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
}