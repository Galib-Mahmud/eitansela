import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../notification/views/notifications_screen.dart';
import '../../../order/views/in_progress_screen.dart';
import '../../recent_request_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

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
              _buildHeader(),
              SizedBox(height: 20.h),
              _buildSearchBar(),
              SizedBox(height: 24.h),
              _buildRecentRequestHeader(),
              SizedBox(height: 12.h),
              _buildRecentRequests(),
              SizedBox(height: 24.h),
              _buildServicesGrid(),
              SizedBox(height: 90.h),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────── Header ──────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
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
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
          // Notification Icon
          GestureDetector(
            onTap: () {
              Get.to(
                  ()=> const NotificationsScreen(),
              );
            },
            child: Icon(
              Icons.notifications_none_rounded,
              color: const Color(0xFF424242),
              size: 26.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────── Search Bar ──────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: const Color(0xFFBDBDBD),
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'What do you need help with?',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFBDBDBD),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────── Recent Request Header ───────────────────────────
  Widget _buildRecentRequestHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Request',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => const RecentRequestScreen(),
              );
            },
            child: Text(
              'See All',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── Recent Request Cards ────────────────────────────
  Widget _buildRecentRequests() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildRecentRequestCard(
            iconPath: 'assets/images/profile/water.png',
            title: 'Kitchen Sink Leak',
            date: 'oct 24 - Complete',
            status: 'IN Process',

          ),
          SizedBox(height: 12.h),
          _buildRecentRequestCard(
            iconPath: 'assets/images/profile/water.png',
            title: 'Kitchen Sink Leak',
            date: 'oct 24 - Complete',
            status: 'IN Process',
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRequestCard({
    required String iconPath,
    required String title,
    required String date,
    required String status,
  }) {
    return GestureDetector(
      onTap: (){
        Get.to(
              () => const InProgressScreen(),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Image.asset(
              iconPath,
              width: 36.w,
              height: 36.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 14.w),
            // Title and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFBDBDBD),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00897B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Services Grid ───────────────────────────────
  Widget _buildServicesGrid() {
    final services = [
      {'image': 'assets/images/profile/water.png', 'label': 'Plumbing'},
      {'image': 'assets/images/profile/2.png', 'label': 'Electrical'},
      {'image': 'assets/images/profile/3.png', 'label': 'Ac & HVAC'},
      {'image': 'assets/images/profile/7.png', 'label': 'Painting'},
      {'image': 'assets/images/profile/8.png', 'label': 'Moving'},
      {'image': 'assets/images/profile/12.png', 'label': 'Gardening'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
          childAspectRatio: 0.95,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(
            imagePath: services[index]['image']!,
            label: services[index]['label']!,
            onTap: () {
              Get.toNamed(RouteName.newRequest);
            },
          );
        },
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
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 44.w,
              height: 44.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF212121),
              ),
            ),
          ],
        ),
      ),
    );
  }
}