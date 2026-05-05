// lib/feature/provider/profile/views/professional_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/professional_profile_controller.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put here — this screen owns this controller lifecycle
    final c = Get.put(ProfessionalProfileScreenController());

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Obx(() {
          if (c.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFF8C106)),
            );
          }
          return Column(
            children: [
              SizedBox(height: 16.h),
              _buildHeader(context, c),
              Divider(height: 20.h, color: const Color(0xFFEEEEEE)),
              Expanded(
                child: RefreshIndicator(
                  color: const Color(0xFFF8C106),
                  onRefresh: () => c.fetchProviderProfile(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h),
                        _buildProfileCard(c),
                        SizedBox(height: 16.h),
                        _buildStatsRow(c),
                        SizedBox(height: 24.h),
                        _buildVerificationsSection(c),
                        SizedBox(height: 24.h),
                        _buildBioSection(c),
                        SizedBox(height: 24.h),
                        _buildAccountActions(context, c),
                        SizedBox(height: 32.h),
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

  // ─────────────────────── Header ────────────────────────────────
  Widget _buildHeader(BuildContext context, ProfessionalProfileScreenController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back,
                size: 22.sp, color: const Color(0xFF212121)),
          ),
          SizedBox(width: 16.w),
          Text(
            'My Profile',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121),
            ),
          ),
          const Spacer(),
          // Logout icon in header
          GestureDetector(
            onTap: () => c.showLogoutDialog(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.logout,
                  size: 18.sp, color: const Color(0xFFE53935)),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── Profile Card ──────────────────────────
  Widget _buildProfileCard(ProfessionalProfileScreenController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // ── Avatar with online dot ─────────────────────────────
          Stack(
            children: [
              Obx(() {
                final imageUrl = c.profilePhotoUrl.value;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _buildAvatarFallback(c),
                  )
                      : _buildAvatarFallback(c),
                );
              }),
              Positioned(
                bottom: 2, right: 2,
                child: Obx(() => Container(
                  width: 14.w, height: 14.w,
                  decoration: BoxDecoration(
                    color: c.isOnline.value
                        ? const Color(0xFF43A047)
                        : const Color(0xFFBDBDBD),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                )),
              ),
            ],
          ),
          SizedBox(width: 14.w),

          // ── Name + Email + Status pill ─────────────────────────
          Expanded(
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        c.userName.value.isNotEmpty
                            ? c.userName.value
                            : 'Professional',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF212121)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (c.isVerified.value) ...[
                      SizedBox(width: 6.w),
                      Icon(Icons.verified,
                          color: const Color(0xFF1565C0), size: 16.sp),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  c.userEmail.value.isNotEmpty ? c.userEmail.value : '—',
                  style: TextStyle(
                      fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                // Online / Offline pill
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: c.isOnline.value
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    c.isOnline.value ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: c.isOnline.value
                          ? const Color(0xFF43A047)
                          : const Color(0xFF9E9E9E),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback(ProfessionalProfileScreenController c) {
    final name = c.userName.value;
    return Container(
      width: 64.w, height: 64.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF8C106),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : 'P',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }

  // ─────────────────────── Stats Row ─────────────────────────────
  Widget _buildStatsRow(ProfessionalProfileScreenController c) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatCard(
            iconWidget: _buildIconCircle(Icons.work_outline,
                const Color(0xFFE3F2FD), const Color(0xFF1E88E5)),
            value: '${c.jobsCount.value}',
            label: 'Jobs',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            iconWidget: _buildIconCircle(Icons.star_border,
                const Color(0xFFFFF8E1), const Color(0xFFF8C106)),
            value: c.rating.value.toStringAsFixed(1),
            label: 'Rating',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            iconWidget: _buildIconCircle(Icons.warning_amber_rounded,
                const Color(0xFFFFEBEE), const Color(0xFFEF5350)),
            value: '${c.emergencyCount.value}',
            label: 'Emergency',
          ),
        ),
      ],
    ));
  }

  Widget _buildIconCircle(IconData icon, Color bg, Color iconColor) {
    return Container(
      width: 36.w, height: 36.w,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 18.sp),
    );
  }

  Widget _buildStatCard({
    required Widget iconWidget,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          iconWidget,
          SizedBox(height: 10.h),
          Text(value,
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF212121))),
          SizedBox(height: 2.h),
          Text(label,
              style: TextStyle(
                  fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  // ─────────────────────── Verifications ─────────────────────────
  Widget _buildVerificationsSection(ProfessionalProfileScreenController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.verified_user_outlined,
                    color: const Color(0xFF43A047), size: 20.sp),
                SizedBox(width: 8.w),
                Text('Verifications',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF212121))),
              ],
            ),
            Obx(() => c.isVerified.value
                ? _statusPill('Verified Pro',
                bg: const Color(0xFFE8F5E9),
                border: const Color(0xFF43A047),
                text: const Color(0xFF43A047))
                : _statusPill('Unverified',
                bg: const Color(0xFFFFF8E1),
                border: const Color(0xFFF8C106),
                text: const Color(0xFFF57F17))),
          ],
        ),
        SizedBox(height: 14.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Obx(() => Column(
            children: [
              _buildTile(Icons.card_membership, 'Certificates',
                  '${c.certificates.value}'),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              _buildTile(
                Icons.event_available,
                'Availability',
                c.isAvailable.value ? 'Available' : 'Unavailable',
                valueColor: c.isAvailable.value
                    ? const Color(0xFF43A047)
                    : const Color(0xFF9E9E9E),
              ),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              _buildTile(
                Icons.verified_user,
                'Account Status',
                c.isVerified.value ? 'Verified' : 'Pending Verification',
                valueColor: c.isVerified.value
                    ? const Color(0xFF43A047)
                    : const Color(0xFFFF8F00),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget _statusPill(String label,
      {required Color bg, required Color border, required Color text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11.sp, fontWeight: FontWeight.w600, color: text)),
    );
  }

  Widget _buildTile(IconData icon, String title, String value,
      {Color valueColor = const Color(0xFF43A047)}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.sp, color: Colors.blueGrey),
              SizedBox(width: 12.w),
              Text(title,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF212121))),
            ],
          ),
          Text(value,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: valueColor)),
        ],
      ),
    );
  }

  // ─────────────────────── Bio Section ───────────────────────────
  Widget _buildBioSection(ProfessionalProfileScreenController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professional Bio',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121)),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Obx(() => Text(
            c.bio.value.isNotEmpty ? c.bio.value : 'No bio provided.',
            style: TextStyle(
                fontSize: 13.sp,
                color: c.bio.value.isNotEmpty
                    ? const Color(0xFF424242)
                    : const Color(0xFF9E9E9E),
                height: 1.6),
          )),
        ),
      ],
    );
  }

  // ─────────────────────── Account Actions ───────────────────────
  Widget _buildAccountActions(
      BuildContext context, ProfessionalProfileScreenController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121)),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              // Logout
              _buildActionTile(
                icon: Icons.logout,
                iconBg: const Color(0xFFFFEBEE),
                iconColor: const Color(0xFFE53935),
                label: 'Log Out',
                labelColor: const Color(0xFFE53935),
                onTap: () => c.showLogoutDialog(context),
              ),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              // Delete account
              _buildActionTile(
                icon: Icons.delete_outline,
                iconBg: const Color(0xFFFFEBEE),
                iconColor: const Color(0xFFE53935),
                label: 'Delete Account',
                labelColor: const Color(0xFFE53935),
                onTap: () => c.showDeleteAccountDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required Color labelColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 36.w, height: 36.w,
              decoration:
              BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 18.sp),
            ),
            SizedBox(width: 14.w),
            Text(label,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: labelColor)),
            const Spacer(),
            Icon(Icons.chevron_right,
                color: const Color(0xFFBDBDBD), size: 20.sp),
          ],
        ),
      ),
    );
  }
}