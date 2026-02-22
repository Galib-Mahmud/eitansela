import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../routes/route_name.dart';
import '../views/application_sent_screen.dart';

class FreeNonBindingSheet extends StatelessWidget {
  const FreeNonBindingSheet({super.key});

  /// Call this to show the sheet
  static void show() {
    Get.bottomSheet(
      const FreeNonBindingSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 36.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Shield icon
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user_outlined,
              color: const Color(0xFF43A047),
              size: 30.sp,
            ),
          ),
          SizedBox(height: 18.h),

          // Title
          Text(
            'Free & Non-Binding',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF212121),
            ),
          ),
          SizedBox(height: 10.h),

          // Subtitle
          Text(
            'Getting a quote is completely free with no obligation. You only pay if you decide to proceed with the service.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9E9E9E),
              height: 1.6,
            ),
          ),
          SizedBox(height: 22.h),

          // Checkpoints
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              children: [
                _buildCheckItem('No upfront payment required'),
                SizedBox(height: 12.h),
                _buildCheckItem('Cancel anytime before confirmation'),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Send an offer button
          GestureDetector(
            onTap: () {
              Get.back(); // close sheet
              Get.to(
                () => const ApplicationSentScreen(),
              );
            },
            child: Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF8C106),
                borderRadius: BorderRadius.circular(30.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'Send an offer',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),

          // Go Back
          GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              'Go Back',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: const BoxDecoration(
            color: Color(0xFF43A047),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: Colors.white, size: 14.sp),
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF212121),
          ),
        ),
      ],
    );
  }
}