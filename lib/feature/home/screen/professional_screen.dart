import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';

class ProfessionalScreen extends StatelessWidget {
  const ProfessionalScreen({Key? key}) : super(key: key);

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
          'Professional',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF212121),
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        children: [
          _buildProfessionalCard(
            name: 'John Moyer',
            profession: 'Plumber',
            priceRange: '₪150-₪350',
            imagePath: 'assets/images/profile/profile.png',
            rating: '100% Trusted',
            onTap: () {
              // Navigate to professional details
              Get.toNamed('/professional-details');
            },
            onDiscussPrice: () {
              // Handle discuss pricing
            },
          ),
          SizedBox(height: 12.h),
          _buildProfessionalCard(
            name: 'John Moyer',
            profession: 'Plumber',
            priceRange: '₪150-₪350',
            imagePath: 'assets/images/profile/profile.png',
            rating: '100% Trusted',
            onTap: () {
              Get.toNamed('/professional-details');
            },
            onDiscussPrice: () {},
          ),
          SizedBox(height: 12.h),
          _buildProfessionalCard(
            name: 'John Moyer',
            profession: 'Plumber',
            priceRange: '₪150-₪350',
            imagePath: 'assets/images/profile/profile.png',
            rating: '100% Trusted',
            onTap: () {
              Get.toNamed('/professional-details');
            },
            onDiscussPrice: () {},
          ),
          SizedBox(height: 12.h),
          _buildProfessionalCard(
            name: 'John Moyer',
            profession: 'Plumber',
            priceRange: '₪150-₪350',
            imagePath: 'assets/images/profile/profile.png',
            rating: '100% Trusted',
            onTap: () {
              Get.toNamed(RouteName.chat);
            },
            onDiscussPrice: () {Get.toNamed(RouteName.chat);},

          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCard({
    required String name,
    required String profession,
    required String priceRange,
    required String imagePath,
    required String rating,
    required VoidCallback onTap,
    required VoidCallback onDiscussPrice,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Verified Badge and Rating
          Row(
            children: [
              // Verified Icon
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: const Color(0xFF4CAF50),
                  size: 12.sp,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Verified Professional',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                ),
              ),
              Spacer(),
              Text(
                rating,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4CAF50),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Professional Info Row
          Row(
            children: [
              // Profile Image
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
              SizedBox(width: 12.w),
              // Name and Profession
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: const Color(0xFF00B4A8),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          profession,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF757575),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Arrow Icon
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF00B4A8),
                  size: 18.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Price Range and Discuss Button
          Row(
            children: [
              // Price Range
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Range',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      priceRange,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF00B4A8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              // Discuss Pricing Button
              GestureDetector(

                onTap: onDiscussPrice,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B4A8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Discuss Pricing',
                    style: TextStyle(
                      fontSize: 12.sp,
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