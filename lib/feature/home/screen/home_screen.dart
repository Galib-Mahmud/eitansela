import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Header Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile/profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Greeting
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning!',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFF757575),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Kurt Cobain',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Notification Icon
                    Container(
                      width: 40.w,
                      height: 40.w,
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.black,
                              size: 26.sp,
                            ),
                          ),
                          Positioned(
                            right: 10.w,
                            top: 10.h,
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00B4A8),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFF00B4A8),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: const Color(0xFF00B4A8),
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'What do you need help with?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF00B4A8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Recent Request Section Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Request',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/my-requests');
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF00B4A8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Recent Request Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildRecentRequestCard(
                      iconPath: 'assets/images/profile/water.png',
                      title: 'Kitchen Sink Leak',
                      date: 'Oct 24 - Complete',
                      status: 'In Process',
                      onTap: () {
                        Get.toNamed(RouteName.myRequest);
                      },
                    ),
                    SizedBox(height: 10.h),
                    _buildRecentRequestCard(
                      iconPath: 'assets/images/profile/water.png',
                      title: 'Kitchen Sink Leak',
                      date: 'Oct 24 - Complete',
                      status: 'In Process',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Services Grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.0,
                  children: [
                    _buildServiceCard(
                      onTap: () {
                        Get.toNamed(RouteName.newRequest);
                      },
                      imagePath: 'assets/images/profile/water.png',
                      label: 'Plumbing',
                    ),
                    _buildServiceCard(
                      onTap: () {
                        Get.toNamed(RouteName.newRequest);
                      },
                      imagePath: 'assets/images/profile/2.png',
                      label: 'Electrical',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/3.png',
                      label: 'Ac & HVAC',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/4.png',
                      label: 'Locksmith',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/5.png',
                      label: 'Handymen',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/6.png',
                      label: 'Carpentry',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/7.png',
                      label: 'Painting',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/8.png',
                      label: 'Moving',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/9.png',
                      label: 'Appliances',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/10.png',
                      label: 'Glass',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/11.png',
                      label: 'Roofing',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/12.png',
                      label: 'Gardening',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/13.png',
                      label: 'IT/NET',
                    ),
                    _buildServiceCard(
                      imagePath: 'assets/images/profile/14.png',
                      label: 'Pest Control',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 90.h), // Bottom padding for navigation bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentRequestCard({
    required String iconPath,
    required String title,
    required String date,
    required String status,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
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
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Image.asset(
                iconPath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            // Title and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7F6),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00B4A8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String imagePath,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Service Icon/Image
            Container(
              width: 48.w,
              height: 48.w,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8.h),
            // Service Label
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF212121),
              ),
            ),
          ],
        ),
      ),
    );
  }
}