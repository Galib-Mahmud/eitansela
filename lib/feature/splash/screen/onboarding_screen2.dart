import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h),
                child: TextButton(
                  onPressed: () {
                    Get.offAllNamed('/main');
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    // Illustration
                    Container(

                      child: Image.asset(
                        'assets/images/splash/2.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Title
                    Text(
                      'Welcome to FixNow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Description
                    Text(
                      'We make sure your experience is safe, smooth, and\nreliable.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Features list
                    _buildFeaturesList(),

                    SizedBox(height: 20.h),

                    // Extra Perks card
                    _buildExtraPerksCard(),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            // Page indicators
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Inactive indicator
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  // Active indicator
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 24.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B4A8),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),

            // Get Started button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/onboarding3');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B4A8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    return Column(
      children: [
        _buildFeatureItem(
          icon: Icons.verified_outlined,
          iconColor: const Color(0xFF4CAF50),
          title: 'Verified Professionals',
          description: 'All service providers are carefully vetted for quality.',
        ),
        SizedBox(height: 16.h),
        _buildFeatureItem(
          icon: Icons.lock_outline,
          iconColor: const Color(0xFF9C27B0),
          title: 'Secure Payments',
          description: 'Your payments are encrypted and fully protected.',
        ),
        SizedBox(height: 16.h),
        _buildFeatureItem(
          icon: Icons.star_outline,
          iconColor: const Color(0xFFFFC107),
          title: 'Trusted by Users',
          description: 'Thousands of people rely on our service every day.',
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF666666),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExtraPerksCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FFFE),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF00B4A8).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Extra Perks for You',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 12.h),
          _buildPerkItem(
            Icons.schedule,
            'On-time Service',
            'We respect your schedule.',
          ),
          SizedBox(height: 10.h),
          _buildPerkItem(
            Icons.support_agent,
            '24/7 Support',
            'Help is just a tap away.',
          ),
          SizedBox(height: 10.h),
          _buildPerkItem(
            Icons.verified,
            'Satisfaction Guarantee',
            'Quality service every time.',
          ),
        ],
      ),
    );
  }

  Widget _buildPerkItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF00B4A8),
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}