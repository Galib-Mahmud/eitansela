import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/job_requests_controller.dart';

class JobRequestsScreen extends StatelessWidget {
  const JobRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(JobRequestsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildHeader(c),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(
                    () => c.requests.isEmpty
                    ? _buildEmpty()
                    : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  itemCount: c.requests.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14.h),
                  itemBuilder: (_, index) => _JobRequestCard(
                    request: c.requests[index],
                    onAccept: () => c.acceptRequest(index),
                    onDecline: () => c.declineRequest(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(JobRequestsController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xFF212121)),
          ),
          SizedBox(width: 14.w),
          Text(
            'Job Requests',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF212121),
            ),
          ),
          const Spacer(),
          Obx(() => Container(
            width: 30.w,
            height: 30.w,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${c.requests.length}',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF8C106),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'No job requests at the moment.',
        style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9E9E9E)),
      ),
    );
  }
}

class _JobRequestCard extends StatelessWidget {
  final JobRequestModel request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _JobRequestCard({
    required this.request,
    required this.onAccept,
    required this.onDecline,
  });

  bool get _isDimmed =>
      request.status == JobStatus.completed || request.status == JobStatus.inProcess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _isDimmed ? const Color(0xFFF5F5F5) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClientRow(),
          SizedBox(height: 14.h),
          _buildIssueBox(),
          SizedBox(height: 12.h),
          _buildAddressRow(),
          SizedBox(height: 12.h),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          SizedBox(height: 12.h),
          _buildBottomRow(),
        ],
      ),
    );
  }

  // ── Client row ──────────────────────────────────────────────────
  Widget _buildClientRow() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: ColorFiltered(
            colorFilter: _isDimmed
                ? const ColorFilter.matrix([
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0, 0, 0, 1, 0,
            ])
                : const ColorFilter.mode(Colors.transparent, BlendMode.color),
            child: Image.asset(
              request.clientImage,
              width: 44.w,
              height: 44.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(Icons.person, size: 22.sp, color: const Color(0xFF9E9E9E)),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.clientName,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: _isDimmed ? const Color(0xFF9E9E9E) : const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Icon(Icons.access_time, size: 12.sp, color: const Color(0xFF9E9E9E)),
                  SizedBox(width: 4.w),
                  Text(
                    request.timeAgo,
                    style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Icon(
          Icons.handyman_outlined,
          size: 22.sp,
          color: _isDimmed ? const Color(0xFFBDBDBD) : const Color(0xFF424242),
        ),
      ],
    );
  }

  // ── Issue box ───────────────────────────────────────────────────
  Widget _buildIssueBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _isDimmed ? const Color(0xFFEEEEEE) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.issueTitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: _isDimmed ? const Color(0xFF9E9E9E) : const Color(0xFF212121),
            ),
          ),
          SizedBox(height: 5.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Ai:  ',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: _isDimmed ? const Color(0xFFBDBDBD) : const Color(0xFFF8C106),
                  ),
                ),
                TextSpan(
                  text: request.aiDiagnosis,
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Address row ─────────────────────────────────────────────────
  Widget _buildAddressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 14.sp, color: const Color(0xFF9E9E9E)),
            SizedBox(width: 4.w),
            Text(request.address,
                style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E))),
          ],
        ),
        Text(request.distance,
            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E))),
      ],
    );
  }

  // ── Bottom row ──────────────────────────────────────────────────
  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Zip Code',
                style: TextStyle(fontSize: 11.sp, color: const Color(0xFF9E9E9E))),
            SizedBox(height: 3.h),
            Text(
              request.zipCode,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: _isDimmed ? const Color(0xFF9E9E9E) : const Color(0xFFF8C106),
              ),
            ),
          ],
        ),
        if (request.status == JobStatus.pending) _buildPendingButtons(),
        if (request.status == JobStatus.completed)
          _buildStatusBadge(label: 'Completed'),
        if (request.status == JobStatus.inProcess)
          _buildStatusBadge(label: 'In Process'),
      ],
    );
  }

  Widget _buildPendingButtons() {
    return Row(
      children: [
        GestureDetector(
          onTap: onDecline,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFE53935), width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.close, color: const Color(0xFFE53935), size: 14.sp),
                SizedBox(width: 6.w),
                Text('Decline',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE53935))),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: onAccept,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF43A047),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.check, color: Colors.white, size: 14.sp),
                SizedBox(width: 6.w),
                Text('Accept',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge({required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.check, color: const Color(0xFF43A047), size: 14.sp),
          SizedBox(width: 6.w),
          Text(label,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF43A047))),
        ],
      ),
    );
  }
}