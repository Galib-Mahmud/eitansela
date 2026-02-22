import 'package:eitansela/feature/customer/notification/views/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/route_name.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

                // adjust to your project

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildHeader(context, c),
            Divider(height: 1, color: const Color(0xFFEEEEEE)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // ── Profile Card ──────────────────────────────
                    _buildProfileCard(c),
                    SizedBox(height: 16.h),

                    // ── Menu Items ────────────────────────────────
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Saved Addresses',
                      subtitle: '3 saved',
                      onTap: () => Get.toNamed(RouteName.savedAddresses),
                    ),
                    SizedBox(height: 12.h),
                    _buildMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'On',
                      onTap: () => Get.to(() => const NotificationsScreen()),
                    ),
                    SizedBox(height: 12.h),
                    _buildMenuItem(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    ),
                    SizedBox(height: 12.h),
                    _buildMenuItem(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    ),
                    SizedBox(height: 32.h),

                    // ── Delete Account Button ─────────────────────
                    GestureDetector(
                      onTap: () => c.showDeleteAccountDialog(context),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 60.w),
                        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(color: const Color(0xFFE53935), width: 1.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outline, color: const Color(0xFFE53935), size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Delete Account',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE53935),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ── Log Out ───────────────────────────────────
                    GestureDetector(
                      onTap: () => c.showLogoutDialog(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded, color: const Color(0xFFE53935), size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFE53935),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── Header ────────────────────────────────
  Widget _buildHeader(BuildContext context, ProfileController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, size: 22.sp, color: Colors.white),
          ),
          Text(
            'Profile',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)),
          ),
          Container(
            width: 34.w,
            height: 34.w,
            decoration: const BoxDecoration(color: Color(0xFF212121), shape: BoxShape.circle),
            child: Icon(Icons.question_mark_rounded, color: Colors.white, size: 16.sp),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── Profile Card ──────────────────────────
  Widget _buildProfileCard(ProfileController c) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: Image.asset(
              c.userImage.value,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Icon(Icons.person, size: 28.sp, color: const Color(0xFF9E9E9E)),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.userName.value,
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121))),
              SizedBox(height: 4.h),
              Text(c.userEmail.value,
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF757575))),
              SizedBox(height: 2.h),
              Text(c.userPhone.value,
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF757575))),
            ],
          )),
        ],
      ),
    );
  }

  // ─────────────────────── Menu Item ─────────────────────────────
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: const Color(0xFF424242), size: 22.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w600, color: const Color(0xFF212121))),
                  SizedBox(height: 4.h),
                  Text(subtitle,
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: const Color(0xFF9E9E9E), size: 16.sp),
          ],
        ),
      ),
    );
  }
}