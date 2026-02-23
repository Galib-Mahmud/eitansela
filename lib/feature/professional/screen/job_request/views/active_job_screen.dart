import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/active_job_controller.dart';



class ActiveJobScreen extends StatelessWidget {
  const ActiveJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ActiveJobController());

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildHeader(c),
            Divider(height: 20.h, color: const Color(0xFFEEEEEE)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    _buildClientCard(c),
                    SizedBox(height: 14.h),
                    _buildJobDetailsCard(c),
                    SizedBox(height: 14.h),
                    _buildProgressCard(c),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _buildBottomButton(c),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── Header ────────────────────────────────
  Widget _buildHeader(ActiveJobController c) {
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
            'Active Job',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF212121),
            ),
          ),
          const Spacer(),
          Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              c.jobStatus.value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1565C0),
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ─────────────────────── Client Card ───────────────────────────
  Widget _buildClientCard(ActiveJobController c) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
            borderRadius: BorderRadius.circular(24.r),
            child: Image.asset(
              c.clientImage.value,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(Icons.person, size: 24.sp, color: const Color(0xFF9E9E9E)),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.clientName.value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 13.sp, color: const Color(0xFF9E9E9E)),
                    SizedBox(width: 3.w),
                    Text(
                      c.clientAddress.value,
                      style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ],
            )),
          ),
          GestureDetector(
            onTap: c.openChat,
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: const BoxDecoration(
                color: Color(0xFF1565C0),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── Job Details Card ──────────────────────
  Widget _buildJobDetailsCard(ActiveJobController c) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Details',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)),
          ),
          SizedBox(height: 14.h),

          // Detected issue box
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detected Issue',
                      style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        c.severity.value,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE53935),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  c.detectedIssue.value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212121),
                  ),
                ),
              ],
            )),
          ),
          SizedBox(height: 12.h),

          // Est. Price box
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
            ),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Est. Price',
                    style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                SizedBox(height: 6.h),
                Text(
                  '${c.estPriceMin.value} – ${c.estPriceMax.value}',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFF8C106),
                  ),
                ),
              ],
            )),
          ),
          SizedBox(height: 16.h),

          Text(
            'Is this price fair?',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)),
          ),
          SizedBox(height: 12.h),

          Obx(() => Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: c.submitGoodEstimation,
                  child: Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF43A047),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: Colors.white, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'Good estimation',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: c.submitBadEstimation,
                  child: Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.thumb_down_outlined,
                            color: const Color(0xFF424242), size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'Bad Estimation',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF424242),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),

          Obx(() => c.priceFeedback.value.isNotEmpty
              ? Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Center(
              child: Text(
                'Thanks for your feedback!',
                style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E)),
              ),
            ),
          )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  // ─────────────────────── Progress Card ─────────────────────────
  Widget _buildProgressCard(ActiveJobController c) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)),
          ),
          SizedBox(height: 20.h),
          Obx(() => Column(
            children: List.generate(c.progressSteps.length, (index) {
              return _buildProgressStep(
                step: c.progressSteps[index],
                isLast: index == c.progressSteps.length - 1,
              );
            }),
          )),
        ],
      ),
    );
  }

  Widget _buildProgressStep({
    required JobProgressStep step,
    required bool isLast,
  }) {
    final isActive = step.status == JobProgressStatus.active;
    final isCompleted = step.status == JobProgressStatus.completed;
    final isPending = step.status == JobProgressStatus.pending;

    Widget leadingIcon;
    if (isCompleted || isActive) {
      leadingIcon = Container(
        width: 36.w,
        height: 36.w,
        decoration: const BoxDecoration(color: Color(0xFF43A047), shape: BoxShape.circle),
        child: Icon(Icons.check, color: Colors.white, size: 18.sp),
      );
    } else {
      leadingIcon = Container(
        width: 36.w,
        height: 36.w,
        decoration: const BoxDecoration(color: Color(0xFFF0F0F0), shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          '${step.number}',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF9E9E9E),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            leadingIcon,
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: isCompleted || isActive
                    ? const Color(0xFF43A047)
                    : const Color(0xFFE0E0E0),
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? const Color(0xFF43A047)
                      : isPending
                      ? const Color(0xFF9E9E9E)
                      : const Color(0xFF212121),
                ),
              ),
              if (step.subtitle != null) ...[
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF43A047),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      step.subtitle!,
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF43A047)),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────── Bottom Button ─────────────────────────
  Widget _buildBottomButton(ActiveJobController c) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: GestureDetector(
        onTap: () {
          // TODO: update job status to On The Way
        },
        child: Container(
          width: double.infinity,
          height: 54.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF8C106),
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                "I'm on The Way",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}