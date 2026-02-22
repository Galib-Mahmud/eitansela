import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/route_name.dart';
import '../controllers/recent_request_controller.dart';
import '../views/in_progress_screen.dart';

class RecentRequestsWidget extends StatelessWidget {
  const RecentRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecentRequestController>();

    return Obx(
          () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: List.generate(controller.requests.length, (index) {
            final item = controller.requests[index];
            return Padding(
              padding: EdgeInsets.only(bottom: index < controller.requests.length - 1 ? 12.h : 0),
              child: _RecentRequestCard(
                iconPath: item.iconPath,
                title: item.title,
                date: item.date,
                status: item.status,
                onTap: index == 0
                    ? () => Get.to(() => const InProgressScreen())
                    : null,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _RecentRequestCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String date;
  final String status;
  final VoidCallback? onTap;

  const _RecentRequestCard({
    required this.iconPath,
    required this.title,
    required this.date,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 36.w, height: 36.w, fit: BoxFit.contain),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFBDBDBD),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00897B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}