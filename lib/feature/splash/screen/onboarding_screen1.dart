import 'package:eitansela/widget/auth/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/route_name.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            // Yellow circle background with illustration
            Container(
              child: Center(
                child: Image.asset(
                  'assets/images/splash/1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const Spacer(flex: 1),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                'Handy Connect – Smart Home\nRepair, Powered by AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                  height: 1.3,
                ),
              ),
            ),

            SizedBox(height: 14.h),

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Connect with verified providers instantly. Your\nprivacy, guaranteed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF999999),
                  height: 1.5,
                ),
              ),
            ),

            const Spacer(flex: 1),

            // Next button
             CustomButton(text: "Next", onPressed: () {
               Get.toNamed(RouteName.signin);
             },),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}