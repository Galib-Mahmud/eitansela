import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewRequestScreen1 extends StatelessWidget {
  const NewRequestScreen1({Key? key}) : super(key: key);

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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),

                    // AI Diagnosis Card
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // AI Diagnosis Header
                          Row(
                            children: [
                              Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F7F6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: const Color(0xFF00B4A8),
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'AI Diagnosis',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF212121),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Detected Issue Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detected Issue',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF9E9E9E),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEBEE),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'High Severity',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFE53935),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.h),

                          // Issue Title
                          Text(
                            'Burst Pipe (Under Sink)',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Suggested Cause Section
                          Text(
                            'Suggested Cause',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          // Cause Description
                          Text(
                            'Likely caused by corrosion or high water pressure affecting the joint connection. Immediate attention recommended to prevent water damage.',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF757575),
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Price and Professional Row
                          Row(
                            children: [
                              // Est. Price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Est. Price',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF9E9E9E),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      '₪350 - ₪500',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF00B4A8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 16.w),

                              // Professional
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Professional',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF9E9E9E),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Plumber',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF212121),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Back Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
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
                ),

                SizedBox(width: 12.w),

                // Continue Button
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.professional);

                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B4A8),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          'continue',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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
    );
  }
}