import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';

class NewRequestAnalysisScreen extends StatefulWidget {
  const NewRequestAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<NewRequestAnalysisScreen> createState() => _NewRequestAnalysisScreenState();
}

class _NewRequestAnalysisScreenState extends State<NewRequestAnalysisScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to diagnosis screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offNamed(RouteName.newRequestScreen1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Request',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF212121),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 24.h),

          // Step Indicators
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _buildStepIndicator(
                  number: '1',
                  label: 'Details',
                  isActive: false,
                  isCompleted: true,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: const Color(0xFF00B4A8),
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                ),
                _buildStepIndicator(
                  number: '2',
                  label: 'Diagnosis',
                  isActive: true,
                  isCompleted: false,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: const Color(0xFFE0E0E0),
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                ),
                _buildStepIndicator(
                  number: '3',
                  label: 'Confirm',
                  isActive: false,
                  isCompleted: false,
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(vertical: 60.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular Progress Indicator
                    SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFF00B4A8),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Title
                    Text(
                      'Analyzing Issue...',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      'Our AI is diagnosing the problem',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator({
    required String number,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isActive || isCompleted ? const Color(0xFF00B4A8) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive || isCompleted ? const Color(0xFF00B4A8) : const Color(0xFFE0E0E0),
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? Icon(
              Icons.check,
              color: Colors.white,
              size: 18.sp,
            )
                : Text(
              number,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF9E9E9E),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: isActive || isCompleted ? const Color(0xFF00B4A8) : const Color(0xFF9E9E9E),
          ),
        ),
      ],
    );
  }
}