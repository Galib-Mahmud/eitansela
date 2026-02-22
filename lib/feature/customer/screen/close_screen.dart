import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RequestClosedScreen extends StatelessWidget {
  const RequestClosedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
                    child: Icon(Icons.arrow_back, color: const Color(0xFF212121), size: 24.sp),
                  ),
                  SizedBox(width: 16.w),
                  Text('New Request', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121))),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Divider(color: const Color(0xFFEEEEEE), thickness: 1, height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Map placeholder
                    _buildMapPlaceholder(),

                    SizedBox(height: 16.h),

                    // Professional card
                    _buildProfessionalCard(),

                    SizedBox(height: 16.h),

                    // Status Timeline - all completed
                    _buildStatusTimeline(),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Closed button at bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: GestureDetector(
                onTap: () => Get.toNamed(RouteName.main),
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8C106),
                    borderRadius: BorderRadius.circular(27.r),
                  ),
                  child: Center(
                    child: Text('Closed', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Map Placeholder ─────────────────────────────
  Widget _buildMapPlaceholder() {
    return Container(
      width: double.infinity,
      height: 170.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Map View (', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9E9E9E))),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3D0),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF8C106), width: 2),
              ),
              child: Center(child: Container(width: 6.w, height: 6.w, decoration: const BoxDecoration(color: Color(0xFFF8C106), shape: BoxShape.circle))),
            ),
            Text(' The Way)', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9E9E9E))),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Professional Card ───────────────────────────
  Widget _buildProfessionalCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/profile/profile.png'), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('David Cohen', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121))),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Icon(Icons.star_border, color: const Color(0xFFF8C106), size: 16.sp),
                      SizedBox(width: 4.w),
                      Text('4.9', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF212121))),
                      SizedBox(width: 4.w),
                      Text('(124 jobs)', style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E))),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.chat_bubble_outline, color: const Color(0xFFF8C106), size: 18.sp),
          ),
        ],
      ),
    );
  }

  // ───────────────────── Status Timeline ─────────────────────────────
  Widget _buildStatusTimeline() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status Timeline', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121))),
          SizedBox(height: 16.h),
          _buildTimelineItem(title: 'Request Received', time: '10:30 AM', isCompleted: true, isLast: false),
          _buildTimelineItem(title: 'Job Accepted', time: '10:35 AM', isCompleted: true, isLast: false),
          _buildTimelineItem(title: 'On The Way', time: '10:45 AM', isCompleted: true, isActive: true, subtitle: "We're working on this step right now.", isLast: false),
          _buildTimelineItem(title: 'In Progress', isCompleted: true, isLast: false),
          _buildTimelineItem(title: 'Completed', isCompleted: true, isLast: false),
          _buildTimelineItem(title: 'Payment', isCompleted: true, isLast: false),
          _buildTimelineItem(title: 'Review', isCompleted: true, isLast: false),
          _buildTimelineItem(title: 'Closed', isCompleted: false, isPending: true, isLast: true),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    String? time,
    String? subtitle,
    bool isCompleted = false,
    bool isActive = false,
    bool isPending = false,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 36.w,
          child: Column(
            children: [
              if (isCompleted)
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle),
                  child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                )
              else if (isPending)
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.access_time, color: Colors.white, size: 16.sp),
                )
              else
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                  ),
                ),
              if (!isLast)
                Container(
                  width: 2,
                  height: subtitle != null ? 40.h : 24.h,
                  color: isCompleted ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
                ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF212121),
                      ),
                    ),
                    if (time != null)
                      Text(time, style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                  ],
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 3.h),
                  Text(subtitle, style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                ],
                SizedBox(height: subtitle != null ? 16.h : 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}