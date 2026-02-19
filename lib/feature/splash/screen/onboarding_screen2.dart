import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding2Screen extends StatefulWidget {
  const Onboarding2Screen({super.key});

  @override
  State<Onboarding2Screen> createState() => _Onboarding2ScreenState();
}

class _Onboarding2ScreenState extends State<Onboarding2Screen> {
  int _selectedRole = 0; // 0 = Customer, 1 = Professional

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Yellow circle with hand/phone illustration
                    Container(

                      child: Center(
                        child: Image.asset(
                          'assets/images/splash/2.png',
                          width: 220.w,
                          height: 220.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Title
                    Text(
                      'Choose your role',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      "Tell us how you'll use Handy Connect",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Role cards
                    Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      child: Column(
                        children: [
                          _buildRoleCard(
                            index: 0,
                            title: 'Customer',
                            subtitle: 'Book trusted home services',
                          ),
                          SizedBox(height: 16.h),
                          _buildRoleCard(
                            index: 1,
                            title: 'Professional',
                            subtitle: 'Offer services & get jobs',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),

            // Get Started button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/onboarding3');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.r),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16.sp,
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
    );
  }

  Widget _buildRoleCard({
    required int index,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedRole == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedRole = index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFF8E1)
              : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFC107)
                : const Color(0xFFE8E8E8),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFFFFC107).withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),

            // Checkmark circle
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFFFFC107)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFFC107)
                      : const Color(0xFFD0D0D0),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.sp,
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}