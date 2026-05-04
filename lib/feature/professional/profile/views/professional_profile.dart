// lib/feature/provider/profile/views/professional_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/professional_profile_controller.dart';
// import '../controllers/select_categories_controller.dart';
// import '../../notification/views/notifications_screen.dart';
// import 'recent_reviews_screen.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfessionalProfileScreenController());

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: Obx(() {
          // ── Full-screen loader on first fetch ──────────────────
          if (c.isLoading.value && c.userName.value.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFF8C106)),
            );
          }

          return Column(
            children: [
              SizedBox(height: 16.h),
              _buildHeader(context, c),
              Expanded(
                child: RefreshIndicator(
                  color: const Color(0xFFF8C106),
                  onRefresh: c.fetchProviderProfile,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // ── Profile Card ──────────────────────────
                        _buildProfileCard(c),
                        SizedBox(height: 16.h),

                        // ── Stats Row ─────────────────────────────
                        _buildStatsRow(c),
                        SizedBox(height: 24.h),

                        // ── Categories Section ────────────────────
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF212121),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildCategoriesCard(context, c),
                        SizedBox(height: 24.h),

                        // ── Recent Reviews ────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Reviews',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF212121),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.to(() => const ReviewsScreen());
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF2563EB),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _buildReviewCard(
                          initials: 'DC',
                          color: const Color(0xFFF59E0B),
                          name: 'David Cohen',
                          rating: 5,
                          comment: 'Excellent work, very professional!',
                        ),
                        SizedBox(height: 10.h),
                        _buildReviewCard(
                          initials: 'SL',
                          color: const Color(0xFFEF4444),
                          name: 'Sarah Levi',
                          rating: 5,
                          comment: 'Fixed the issue quickly. Highly recommend!',
                        ),
                        SizedBox(height: 32.h),

                        // ── Delete Account ────────────────────────
                        GestureDetector(
                          onTap: () => c.showDeleteAccountDialog(context),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40.w),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                  color: const Color(0xFFE53935), width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_outline,
                                    color: const Color(0xFFE53935),
                                    size: 18.sp),
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

                        // ── Log Out ───────────────────────────────
                        GestureDetector(
                          onTap: () => c.showLogoutDialog(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded,
                                  color: const Color(0xFFE53935), size: 20.sp),
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
              ),
            ],
          );
        }),
      ),
    );
  }

  // ─────────────────────── Header ──────────────────────────────────
  Widget _buildHeader(
      BuildContext context, ProfessionalProfileScreenController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back,
                size: 22.sp, color: const Color(0xFF212121)),
          ),
          SizedBox(width: 12.w),
          Text(
            'My Profile',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121),
            ),
          ),
          const Spacer(),
          // Pull-to-refresh also works; this is a manual reload button
          Obx(() => c.isLoading.value
              ? SizedBox(
            width: 20.w,
            height: 20.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFFF8C106),
            ),
          )
              : GestureDetector(
            onTap: c.fetchProviderProfile,
            child: Icon(Icons.refresh_rounded,
                size: 22.sp, color: const Color(0xFF212121)),
          )),
        ],
      ),
    );
  }

  // ─────────────────────── Profile Card ────────────────────────────
  Widget _buildProfileCard(ProfessionalProfileScreenController c) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // ── Avatar: network photo OR initials fallback ─────────
          Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: c.profilePhotoUrl.value.isNotEmpty
                ? Image.network(
              c.profilePhotoUrl.value,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  _initialsAvatar(c.userName.value),
            )
                : _initialsAvatar(c.userName.value),
          )),
          SizedBox(width: 16.w),
          Obx(() => Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + verified badge
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        c.userName.value.isEmpty ? '—' : c.userName.value,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF212121),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (c.isVerified.value) ...[
                      SizedBox(width: 6.w),
                      Icon(Icons.verified_rounded,
                          color: const Color(0xFF2563EB), size: 16.sp),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                // Category
                Text(
                  c.categoryName.value,
                  style: TextStyle(
                      fontSize: 13.sp, color: const Color(0xFF757575)),
                ),
                if (c.zipCode.value.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 13.sp, color: const Color(0xFF9E9E9E)),
                      SizedBox(width: 2.w),
                      Text(
                        c.zipCode.value,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF9E9E9E)),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _initialsAvatar(String name) {
    String initials = '?';
    if (name.trim().isNotEmpty) {
      final parts = name.trim().split(' ');
      initials = parts.length >= 2
          ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
          : parts[0][0].toUpperCase();
    }
    return Container(
      width: 56,
      height: 56,
      color: const Color(0xFFF8C106).withOpacity(0.15),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFFF8C106),
        ),
      ),
    );
  }

  // ─────────────────────── Stats Row ───────────────────────────────
  Widget _buildStatsRow(ProfessionalProfileScreenController c) {
    return Obx(() => Row(
      children: [
        _buildStatCard(
          icon: Icons.bolt_outlined,
          iconColor: const Color(0xFFEF4444),
          value: c.emergencyCount.value.toString(),
          label: 'Emergency',
        ),
        SizedBox(width: 10.w),
        _buildStatCard(
          icon: Icons.check_circle_outline,
          iconColor: const Color(0xFF22C55E),
          value: c.jobsCount.value.toString(),
          label: 'Jobs',
        ),
        SizedBox(width: 10.w),
        _buildStatCard(
          icon: Icons.star_outline_rounded,
          iconColor: const Color(0xFFF59E0B),
          // rating from API e.g. "5.00"
          value: c.rating.value.toStringAsFixed(1),
          label: 'Rating',
        ),
      ],
    ));
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF212121),
              ),
            ),
            SizedBox(height: 2.h),
            Text(label,
                style:
                TextStyle(fontSize: 11.sp, color: const Color(0xFF9E9E9E))),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── Categories Card ─────────────────────────
  Widget _buildCategoriesCard(
      BuildContext context, ProfessionalProfileScreenController c) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          _buildCategoryItem(
            icon: Icons.person_outline,
            title: 'Personal Info',
            trailing: Icon(Icons.arrow_forward_ios,
                size: 14.sp, color: const Color(0xFF9E9E9E)),
            showDivider: true,
            onTap: () {},
          ),
          _buildCategoryItem(
            icon: Icons.shield_outlined,
            title: 'ID Verification',
            trailing: Obx(() => Container(
              padding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: c.isVerified.value
                    ? const Color(0xFFDCFCE7)
                    : const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                c.isVerified.value ? 'Verified' : 'Pending',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: c.isVerified.value
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFE65100),
                ),
              ),
            )),
            showDivider: true,
            onTap: () {},
          ),
          _buildCategoryItem(
            icon: Icons.description_outlined,
            title: 'Certificates',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward_ios,
                    size: 14.sp, color: const Color(0xFF9E9E9E)),
              ],
            ),
            showDivider: true,
            onTap: () {},
          ),
          _buildCategoryItem(
            icon: Icons.location_on_outlined,
            title: 'Service Areas',
            trailing: Icon(Icons.arrow_forward_ios,
                size: 14.sp, color: const Color(0xFF9E9E9E)),
            showDivider: true,
            onTap: () {},
          ),
          _buildCategoryItem(
            icon: Icons.add_location_outlined,
            title: 'Add Services',
            trailing: Icon(Icons.arrow_forward_ios,
                size: 14.sp, color: const Color(0xFF9E9E9E)),
            showDivider: false,
            onTap: () {
              // SelectCategoriesController.show(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    required bool showDivider,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(icon, size: 22.sp, color: const Color(0xFF424242)),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF212121),
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              indent: 16.w,
              endIndent: 16.w,
              color: const Color(0xFFEEEEEE),
            ),
        ],
      ),
    );
  }

  // ─────────────────────── Review Card ─────────────────────────────
  Widget _buildReviewCard({
    required String initials,
    required Color color,
    required String name,
    required int rating,
    required String comment,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Row(
                      children: List.generate(
                        5,
                            (i) => Icon(
                          i < rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 14.sp,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  comment,
                  style: TextStyle(
                      fontSize: 12.sp, color: const Color(0xFF757575)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}