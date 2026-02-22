import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widget/free_non_binding_sheet.dart';

class NewRequestScreen1 extends StatelessWidget {
  const NewRequestScreen1({super.key});

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
            const Divider(color: Color(0xFFEEEEEE), thickness: 1, height: 1),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // AI Diagnosis Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                width: 34.w,
                                height: 34.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF8E1),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFF8C106), width: 2),
                                ),
                                child: Center(
                                  child: Icon(Icons.check, color: const Color(0xFFF8C106), size: 18.sp),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'AI Diagnosis',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF212121),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),

                          // Detected Issue box
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Detected Issue',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color(0xFFF8C106),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEBEE),
                                        borderRadius: BorderRadius.circular(6.r),
                                      ),
                                      child: Text(
                                        'High Severity',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFE53935),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Burst Pipe (Under Sink)',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF212121),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 18.h),

                          // Suggested Cause
                          Text(
                            'Suggested Cause',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFFF8C106),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Likely caused by corrosion or high water pressure affecting the joint connection. Immediate attention recommended to prevent water damage.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF616161),
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Price + Professional row
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(14.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Est. Price',
                                          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                                      SizedBox(height: 6.h),
                                      Text('₪350 - ₪500',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFFF8C106))),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(14.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Professional',
                                          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                                      SizedBox(height: 6.h),
                                      Text('Plumber',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF212121))),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 28.h),
              child: Row(
                children: [
                  // Back button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.r),
                          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Continue button → shows bottom sheet
                  Expanded(
                    child: GestureDetector(
                      onTap: FreeNonBindingSheet.show, // ← changed
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8C106),
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}