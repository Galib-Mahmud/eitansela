import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/recent_request_controller.dart';
import '../widgets/recent_requests_widget.dart';


class RecentRequestScreen extends StatelessWidget {
  const RecentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    Get.put(RecentRequestController());

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            _buildHeader(),
            Divider(height: 24.h, color: const Color(0xFFEEEEEE)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                child: const RecentRequestsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xFF212121)),
          ),
          SizedBox(width: 16.w),
          Text(
            'Recent Request',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }
}