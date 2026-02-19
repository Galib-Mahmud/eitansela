import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentRequestScreen extends StatelessWidget {
  const RecentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            // App bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF212121),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Recent Request',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF212121),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Divider
            Divider(
              color: const Color(0xFFEEEEEE),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 8.h),
            // Request list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildRequestCard(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Water icon
          Image.asset(
            'assets/images/profile/water.png',
            width: 36.w,
            height: 36.w,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 14.w),
          // Title + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kitchen Sink Leak',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'oct 24 - Complete',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFFBDBDBD),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Status badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'IN Process',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00897B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}