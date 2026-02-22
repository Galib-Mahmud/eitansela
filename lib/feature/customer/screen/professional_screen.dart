import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';
import '../profile/views/profile_screen.dart';
import '../order/views/in_progress_screen.dart';
import '../profile/views/professional_profile_screen.dart';
import 'my_request_screen.dart';

class ProfessionalScreen extends StatelessWidget {
  const ProfessionalScreen({super.key});

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
                    child: Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF212121),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Professional',
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
              color: const Color(0xFFEEEEEE),
              thickness: 1,
              height: 1,
            ),

            // List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                children: [
                  _buildProfessionalCard(
                    name: 'John Mayer',
                    profession: 'Plumber',
                    priceRange: '5645',
                    imagePath: 'assets/images/profile/profile.png',

                  ),
                  SizedBox(height: 14.h),
                  _buildProfessionalCard(
                    name: 'John Mayer',
                    profession: 'Plumber',
                    priceRange: '6877',
                    imagePath: 'assets/images/profile/profile.png',

                  ),
                  SizedBox(height: 14.h),
                  _buildProfessionalCard(
                    name: 'John Mayer',
                    profession: 'Plumber',
                    priceRange: '5647',
                    imagePath: 'assets/images/profile/profile.png',

                  ),
                  SizedBox(height: 14.h),
                  _buildProfessionalCard(
                    name: 'John Mayer',
                    profession: 'Plumber',
                    priceRange: '5784',
                    imagePath: 'assets/images/profile/profile.png',

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalCard({
    required String name,
    required String profession,
    required String priceRange,
    required String imagePath,

  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Row 1: Verified badge + 100% Trusted
          Row(
            children: [
              // Green shield check icon
              Container(
                width: 26.w,
                height: 26.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user,
                  color: const Color(0xFF4CAF50),
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Verified Professional',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF212121),
                ),
              ),
              const Spacer(),
              // 100% Trusted badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '100% Trusted',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Row 2: Avatar + Name + Profession + Arrow
          GestureDetector(
            onTap: (){
              Get.to(
                () => const ProfessionalProfileScreen(),
              );
            },
            child: Row(
              children: [
                // Profile image with green online dot
                SizedBox(
                  width: 48.w,
                  height: 48.w,
                  child: Stack(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Green online dot
                      Positioned(
                        bottom: 2,
                        left: 2,
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // Name + Profession
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF212121),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          // Water drop icon
                          Image.asset(
                            'assets/images/profile/water.png',
                            width: 14.w,
                            height: 14.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            profession,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Yellow arrow
                GestureDetector(
                  onTap: (){
                    Get.to(
                      () => const ProfessionalProfileScreen(),
                    );
                  },
                  child: Icon(
                    Icons.chevron_right,
                    color: const Color(0xFFF8C106),
                    size: 28.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 14.h),

          // Divider
          Divider(
            color: const Color(0xFFEEEEEE),
            thickness: 1,
            height: 1,
          ),

          SizedBox(height: 14.h),

          // Row 3: Price Range + Discuss Pricing button
          Row(
            children: [
              // Price Range
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zip Code',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      priceRange,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF8C106),
                      ),
                    ),
                  ],
                ),
              ),
              // Discuss Pricing button
              GestureDetector(
                onTap:(){
                  Get.to(
                        () => const InProgressScreen(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8C106),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Send Request',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}