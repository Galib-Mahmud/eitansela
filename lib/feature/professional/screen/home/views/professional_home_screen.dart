import 'package:eitansela/feature/customer/notification/views/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../customer/screen/home/controllers/report_issue_controller.dart';
import '../../activejobscreen.dart';
import '../controllers/professional_home_controller.dart';

class ProfessionalHomeScreen extends StatelessWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfessionalHomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(c),
              SizedBox(height: 12.h),
              _buildOnlineToggle(c),
              SizedBox(height: 12.h),
              _buildStatsRow(c),
              SizedBox(height: 20.h),
              _buildSectionHeader(
                title: 'Active Jobs',
                badge: c.activeJobs.length.toString(),
              ),
              SizedBox(height: 10.h),
              Obx(() => Column(
                children: c.activeJobs
                    .map((job) => _buildActiveJobCard(job,context))
                    .toList(),
              )),
              SizedBox(height: 20.h),
              _buildSectionHeader(
                title: 'Emergency Request',
                showViewAll: true,
                onViewAll: () {},
              ),
              SizedBox(height: 10.h),
              Obx(() => Column(
                children: c.emergencyRequests
                    .map((r) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildJobRequestCard(r),
                ))
                    .toList(),
              )),
              SizedBox(height: 8.h),
              _buildSectionHeader(
                title: 'New Requests',
                showViewAll: true,
                onViewAll: () {},
              ),
              SizedBox(height: 10.h),
              Obx(() => Column(
                children: c.newRequests
                    .map((r) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildJobRequestCard(r),
                ))
                    .toList(),
              )),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────── Profile Card ──────────────────────────────
  Widget _buildProfileCard(ProfessionalHomeController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: Image.asset(
              c.professionalImage.value,
              width: 52.w,
              height: 52.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Icon(Icons.person, size: 28.sp, color: const Color(0xFF9E9E9E)),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.professionalName.value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Professional',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                ),
              ],
            )),
          ),
          GestureDetector(
            onTap: (){
              Get.to(
                () => const NotificationsScreen(),
              );
            },
            child: Stack(
              children: [
                Icon(Icons.notifications, color: const Color(0xFF212121), size: 26.sp),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8C106),
                      shape: BoxShape.circle,
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

  // ─────────────────── Online Toggle ─────────────────────────────
  Widget _buildOnlineToggle(ProfessionalHomeController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Obx(() => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.isOnline.value ? "You're Online" : "You're Offline",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  c.isOnline.value
                      ? 'Receiving new job requests'
                      : 'Not receiving job requests',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
          Switch(
            value: c.isOnline.value,
            onChanged: c.toggleOnline,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF43A047),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFBDBDBD),
          ),
        ],
      )),
    );
  }

  // ─────────────────── Stats Row ─────────────────────────────────
  Widget _buildStatsRow(ProfessionalHomeController c) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatCard(
            iconWidget: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: Icon(Icons.check_circle_outline, color: const Color(0xFF43A047), size: 20.sp),
            ),
            value: '${c.emergencyCount.value}',
            label: 'Emergency',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildStatCard(
            iconWidget: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: Icon(Icons.check_circle_outline, color: const Color(0xFF43A047), size: 20.sp),
            ),
            value: '${c.jobsCount.value}',
            label: 'Jobs',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildStatCard(
            iconWidget: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(color: Color(0xFFFFF8E1), shape: BoxShape.circle),
              child: Icon(Icons.star_border, color: const Color(0xFFF8C106), size: 20.sp),
            ),
            value: '${c.rating.value}',
            label: 'Rating',
          ),
        ),
      ],
    ));
  }

  Widget _buildStatCard({required Widget iconWidget, required String value, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          iconWidget,
          SizedBox(height: 8.h),
          Text(value,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF212121))),
          SizedBox(height: 2.h),
          Text(label, style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  // ─────────────────── Section Header ────────────────────────────
  Widget _buildSectionHeader({
    required String title,
    String? badge,
    bool showViewAll = false,
    VoidCallback? onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.w800, color: const Color(0xFF212121))),
            if (badge != null) ...[
              SizedBox(width: 8.w),
              Container(
                width: 22.w,
                height: 22.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8C106),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(badge,
                    style: TextStyle(
                        fontSize: 11.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ],
        ),
        if (showViewAll)
          GestureDetector(
            onTap: onViewAll,
            child: Row(
              children: [
                Text('View All',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1565C0))),
                SizedBox(width: 2.w),
                Icon(Icons.chevron_right, color: const Color(0xFF1565C0), size: 16.sp),
              ],
            ),
          ),
      ],
    );
  }

  // ─────────────────── Active Job Card ───────────────────────────
  Widget _buildActiveJobCard(ActiveJobModel job, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
                onTap: (){
                  Get.to(
                          () => const ActiveJobScreen());
                },
                child: Icon(Icons.ac_unit, color: const Color(0xFF90CAF9), size: 24.sp)),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Get.to(
                  () => const ActiveJobScreen());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.clientName,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF212121))),
                  SizedBox(height: 4.h),
                  Text(job.address,
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              GestureDetector(
                  onTap: () => ReportIssueController.show(context, jobType: 'Plumbing'),

                  child: Icon(Icons.flag_outlined, color: const Color(0xFF9E9E9E), size: 18.sp)
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  job.status,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────── Job Request Card ──────────────────────────

  Widget _buildJobRequestCard(JobRequestModel request) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: request.isSold ? const Color(0xFFF5F5F5) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    request.iconPath,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.contain,
                    // color: request.isSold ? const Color(0xFFBDBDBD) : null,
                    colorBlendMode: request.isSold ? BlendMode.saturation : null,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.water_drop, color: const Color(0xFF64B5F6), size: 36.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.service,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: request.isSold
                                ? const Color(0xFF9E9E9E)
                                : const Color(0xFF212121),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 12.sp, color: const Color(0xFF9E9E9E)),
                            SizedBox(width: 4.w),
                            Text(request.date,
                                style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'New',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF43A047),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              const Divider(height: 1, color: Color(0xFFF5F5F5)),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total',
                          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                      SizedBox(height: 4.h),
                      Text(
                        request.total,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: request.isSold
                              ? const Color(0xFF9E9E9E)
                              : const Color(0xFFF8C106),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Distance',
                          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 14.sp, color: const Color(0xFF9E9E9E)),
                          SizedBox(width: 2.w),
                          Text(request.distance,
                              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF424242))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── "Lead Already Sold" overlay badge ─────────────────────
        if (request.isSold)
          Positioned.fill(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF474747),
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, color: Colors.white, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Lead Already Sold',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

}