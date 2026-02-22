import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';

class NewRequestAnalysisScreen extends StatefulWidget {
  const NewRequestAnalysisScreen({super.key});

  @override
  State<NewRequestAnalysisScreen> createState() =>
      _NewRequestAnalysisScreenState();
}

class _NewRequestAnalysisScreenState extends State<NewRequestAnalysisScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offNamed(RouteName.newRequestScreen1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
                    'New Request',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF212121),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Divider(
              color: const Color(0xFFE0E0E0),
              thickness: 1,
              height: 1,
            ),

            // Centered analysis card
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 60.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Yellow circular progress
                      SizedBox(
                        width: 80.w,
                        height: 80.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 7,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFF8C106),
                          ),
                          backgroundColor: const Color(0xFFFFF3D0),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Title
                      Text(
                        'Analyzing Issue...',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF212121),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Subtitle
                      Text(
                        'Our AI is diagnosing the problem',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
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