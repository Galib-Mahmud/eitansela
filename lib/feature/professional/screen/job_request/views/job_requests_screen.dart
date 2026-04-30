// lib/features/professional/job_requests/views/job_requests_screen.dart

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
              child: Obx(() {
                // ── Loading ──────────────────────────────────────
                if (c.isLoading.value &&
                    c.activeAndCompleted.isEmpty &&
                    c.newLeads.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: Color(0xFFF8C106)),
                  );
                }

                // ── Empty ────────────────────────────────────────
                if (c.activeAndCompleted.isEmpty && c.newLeads.isEmpty) {
                  return _buildEmpty();
                }

                // ── List ─────────────────────────────────────────
                return RefreshIndicator(
                  color: const Color(0xFFF8C106),
                  onRefresh: () => c.fetchRequests(),
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 4.h),
                    children: [

                      // ── Active / Completed section ─────────────
                      if (c.activeAndCompleted.isNotEmpty) ...[
                        _buildSectionLabel('Active & Completed'),
                        SizedBox(height: 10.h),
                        ...c.activeAndCompleted.map((r) => Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: _JobRequestCard(
                            request: r,
                            status: JobRequestsController.statusFromString(
                                r['status'] ?? ''),
                            onAccept: () => c.acceptRequest(r['id']),
                            onDecline: () => c.declineRequest(r['id']),
                          ),
                        )),
                        SizedBox(height: 8.h),
                      ],

                      // ── New Leads section ──────────────────────
                      if (c.newLeads.isNotEmpty) ...[
                        _buildSectionLabel('New Leads'),
                        SizedBox(height: 10.h),
                        ...c.newLeads.map((r) => Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: _JobRequestCard(
                            request: r,
                            status: JobRequestsController.statusFromString(
                                r['status'] ?? ''),
                            onAccept: () => c.acceptRequest(r['id']),
                            onDecline: () => c.declineRequest(r['id']),
                          ),
                        )),
                      ],

                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Label ─────────────────────────────────────────────────
  Widget _buildSectionLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF9E9E9E),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────
  Widget _buildHeader(JobRequestsController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back,
                size: 22.sp, color: const Color(0xFF212121)),
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
              '${c.totalCount}',
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

  // ── Empty ─────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined,
              size: 60.sp, color: const Color(0xFFBDBDBD)),
          SizedBox(height: 12.h),
          Text(
            'No job requests at the moment.',
            style: TextStyle(
                fontSize: 14.sp, color: const Color(0xFF9E9E9E)),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  Job Request Card
// ══════════════════════════════════════════════════════════════════

class _JobRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final JobStatus status;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _JobRequestCard({
    required this.request,
    required this.status,
    required this.onAccept,
    required this.onDecline,
  });

  bool get _isDimmed =>
      status == JobStatus.completed || status == JobStatus.inProcess;

  // ── Helpers ───────────────────────────────────────────────────────
  String get _clientName   => request['customer_name'] ?? 'Customer';
  String get _timeAgo      => request['formatted_date'] ?? '';
  String get _issueTitle   =>
      request['service_details']?['name_en'] ??
          request['service_name'] ??
          'Service Request';
  String get _aiDiagnosis  => request['ai_summary'] ?? request['ai_cost'] ?? '—';
  String get _address      => request['address'] ?? '';
  String get _zipCode      => request['zip_code'] ?? '—';
  String get _customerPhoto => request['customer_photo'] ?? '';
  String get _assetPath    =>
      JobRequestsController.assetFromIcon(request['service_icon'] ?? '');
  bool   get _isSold       => request['is_sold'] ?? false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),

        // ── Sold overlay ─────────────────────────────────────────
        if (_isSold)
          Positioned.fill(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 10.h),
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
                    Icon(Icons.info_outline,
                        color: Colors.white, size: 16.sp),
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

  // ── Client Row ────────────────────────────────────────────────────
  Widget _buildClientRow() {
    return Row(
      children: [
        // Customer Photo
        ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: _customerPhoto.isNotEmpty
              ? ColorFiltered(
            colorFilter: _isDimmed
                ? const ColorFilter.matrix([
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0, 0, 0, 1, 0,
            ])
                : const ColorFilter.mode(
                Colors.transparent, BlendMode.color),
            child: Image.network(
              _customerPhoto,
              width: 44.w,
              height: 44.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildAvatarFallback(),
            ),
          )
              : _buildAvatarFallback(),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _clientName,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: _isDimmed
                      ? const Color(0xFF9E9E9E)
                      : const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 12.sp, color: const Color(0xFF9E9E9E)),
                  SizedBox(width: 4.w),
                  Text(
                    _timeAgo,
                    style: TextStyle(
                        fontSize: 12.sp, color: const Color(0xFF9E9E9E)),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Service Icon
        Image.asset(
          _assetPath,
          width: 28.w,
          height: 28.w,
          fit: BoxFit.contain,
          color: _isDimmed ? const Color(0xFFBDBDBD) : null,
          colorBlendMode: _isDimmed ? BlendMode.saturation : null,
        ),
      ],
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF8C106),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Center(
        child: Text(
          _clientName.isNotEmpty ? _clientName[0].toUpperCase() : 'C',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }

  // ── Issue Box ─────────────────────────────────────────────────────
  Widget _buildIssueBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _isDimmed
            ? const Color(0xFFEEEEEE)
            : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _issueTitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: _isDimmed
                  ? const Color(0xFF9E9E9E)
                  : const Color(0xFF212121),
            ),
          ),
          SizedBox(height: 5.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'AI:  ',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: _isDimmed
                        ? const Color(0xFFBDBDBD)
                        : const Color(0xFFF8C106),
                  ),
                ),
                TextSpan(
                  text: _aiDiagnosis,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Address Row ───────────────────────────────────────────────────
  Widget _buildAddressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 14.sp, color: const Color(0xFF9E9E9E)),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  _address,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Bottom Row ────────────────────────────────────────────────────
  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Zip Code',
                style: TextStyle(
                    fontSize: 11.sp, color: const Color(0xFF9E9E9E))),
            SizedBox(height: 3.h),
            Text(
              _zipCode,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: _isDimmed
                    ? const Color(0xFF9E9E9E)
                    : const Color(0xFFF8C106),
              ),
            ),
          ],
        ),
        if (status == JobStatus.pending && !_isSold)
          _buildPendingButtons(),
        if (status == JobStatus.completed)
          _buildStatusBadge(label: 'Completed'),
        if (status == JobStatus.inProcess)
          _buildStatusBadge(label: 'In Process'),
      ],
    );
  }

  // ── Pending Buttons ───────────────────────────────────────────────
  Widget _buildPendingButtons() {
    return Row(
      children: [
        GestureDetector(
          onTap: onDecline,
          child: Container(
            padding:
            EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: const Color(0xFFE53935), width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.close,
                    color: const Color(0xFFE53935), size: 14.sp),
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
            padding:
            EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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

  // ── Status Badge ──────────────────────────────────────────────────
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