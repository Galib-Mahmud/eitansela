// lib/features/recent_request_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../order/views/in_progress_screen.dart';
import 'home/controllers/home_controller.dart';

class RecentRequestScreen extends StatelessWidget {
  const RecentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController ctrl = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back,
                        color: const Color(0xFF212121), size: 24.sp),
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
            Divider(color: const Color(0xFFEEEEEE), thickness: 1, height: 1),
            SizedBox(height: 8.h),

            // List
            Expanded(
              child: Obx(() {
                // Loading state
                if (ctrl.isLoading.value && ctrl.allRequests.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFF8C106)),
                  );
                }

                // Empty state
                if (ctrl.allRequests.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_outlined,
                            size: 60.sp, color: const Color(0xFFBDBDBD)),
                        SizedBox(height: 12.h),
                        Text(
                          'No requests found',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: const Color(0xFFF8C106),
                  onRefresh: () => ctrl.fetchAllRequests(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 8.h),
                    itemCount: ctrl.allRequests.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildRequestCard(ctrl.allRequests[index]),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> item) {
    final status      = item['status'] ?? 'PENDING';
    final displayText = item['display_text'] ?? '';
    final serviceName = item['service_name']?.toString().isNotEmpty == true
        ? item['service_name']
        : 'Service Request';
    final assetPath   = HomeController.assetFromString(item['service_icon'] ?? '');

    return GestureDetector(
      onTap: () => Get.to(() => const InProgressScreen()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Asset Image
            Image.asset(
              assetPath,
              width: 36.w,
              height: 36.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 14.w),
            // Title + Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFBDBDBD),
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: HomeController.statusBgColor(status),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: HomeController.statusColor(status),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}