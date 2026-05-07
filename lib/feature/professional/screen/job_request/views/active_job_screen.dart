// lib/features/professional/activejob/views/active_job_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/active_job_controller.dart';

// ── Use GetView so the controller is bound once and never re-created ──
class ActiveJobScreen extends GetView<ActiveJobController> {
  const ActiveJobScreen({super.key});

  // GetX binds the controller before build() is called when you use
  // Get.to(() => ActiveJobScreen()) — no Get.put needed inside build().
  @override
  ActiveJobController get controller =>
      Get.put(ActiveJobController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildHeader(),
            Divider(height: 20.h, color: const Color(0xFFEEEEEE)),
            Expanded(
              child: Obx(() => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    _buildClientCard(),
                    SizedBox(height: 14.h),
                    _buildJobDetailsCard(),
                    SizedBox(height: 14.h),
                    _buildProgressCard(),
                    if (controller.isInProgress) ...[
                      SizedBox(height: 14.h),
                      _buildBillUploadCard(),
                    ],
                    SizedBox(height: 24.h),
                  ],
                ),
              )),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── Header ──────────────────────────────
  Widget _buildHeader() {
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
          Text('Active Job',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF212121))),
          const Spacer(),
          Obx(() => Container(
            padding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _statusBg(controller.jobStatusCode.value),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              controller.jobStatus.value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _statusColor(controller.jobStatusCode.value),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Color _statusBg(String code) {
    switch (code) {
      case 'COMPLETED':   return const Color(0xFFE8F5E9);
      case 'ON_THE_WAY':  return const Color(0xFFFFF8E1);
      case 'IN_PROGRESS': return const Color(0xFFFFF3E0);
      default:            return const Color(0xFFE3F2FD);
    }
  }

  Color _statusColor(String code) {
    switch (code) {
      case 'COMPLETED':   return const Color(0xFF2E7D32);
      case 'ON_THE_WAY':  return const Color(0xFFF57F17);
      case 'IN_PROGRESS': return const Color(0xFFE65100);
      default:            return const Color(0xFF1565C0);
    }
  }

  // ───────────────────────── Client Card ─────────────────────────
  Widget _buildClientCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _card(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: controller.clientImage.value.isNotEmpty
                ? Image.network(
              controller.clientImage.value,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  _avatar(controller.clientName.value),
            )
                : _avatar(controller.clientName.value),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.clientName.value,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Row(children: [
                  Icon(Icons.location_on_outlined,
                      size: 13.sp, color: const Color(0xFF9E9E9E)),
                  SizedBox(width: 3.w),
                  Flexible(
                    child: Text(controller.clientAddress.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF9E9E9E))),
                  ),
                ]),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.openChat,
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: const BoxDecoration(
                  color: Color(0xFF1565C0), shape: BoxShape.circle),
              child: Icon(Icons.chat_bubble_outline,
                  color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(String name) => Container(
    width: 48.w,
    height: 48.w,
    decoration: BoxDecoration(
        color: const Color(0xFFF8C106),
        borderRadius: BorderRadius.circular(24.r)),
    child: Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'C',
        style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    ),
  );

  // ───────────────────────── Job Details ─────────────────────────
  Widget _buildJobDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Details',
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 14.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Service',
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF9E9E9E))),
                    Obx(() => Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: controller.severity.value == 'Priority'
                            ? const Color(0xFFFFEBEE)
                            : const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        controller.severity.value,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: controller.severity.value == 'Priority'
                              ? const Color(0xFFE53935)
                              : const Color(0xFF43A047),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 8.h),
                Obx(() => Text(controller.detectedIssue.value,
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w700))),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border:
              Border.all(color: const Color(0xFFEEEEEE), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Est. Price',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF9E9E9E))),
                SizedBox(height: 6.h),
                Obx(() => Text(
                  '${controller.estCurrency.value} '
                      '${controller.estPriceMin.value} – '
                      '${controller.estPriceMax.value}',
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF8C106)),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── Progress ────────────────────────────
  Widget _buildProgressCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress',
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 20.h),
          Obx(() => Column(
            children: List.generate(
              controller.progressSteps.length,
                  (i) => _buildStep(
                controller.progressSteps[i],
                isLast: i == controller.progressSteps.length - 1,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildStep(JobProgressStep step, {required bool isLast}) {
    final done   = step.status == JobProgressStatus.completed;
    final active = step.status == JobProgressStatus.active;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: done
                  ? const Color(0xFF43A047)
                  : active
                  ? const Color(0xFFF8C106)
                  : const Color(0xFFEEEEEE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              done ? Icons.check : Icons.circle,
              size: done ? 16.sp : 8.sp,
              color: Colors.white,
            ),
          ),
          if (!isLast)
            Container(
                width: 2.w,
                height: 30.h,
                color: done
                    ? const Color(0xFF43A047)
                    : const Color(0xFFEEEEEE)),
        ]),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(step.label,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: active
                          ? FontWeight.w700
                          : FontWeight.w500)),
              if (step.subtitle != null)
                Text(step.subtitle!,
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9E9E9E))),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  // ───────────────────────── Bill Upload ─────────────────────────
  Widget _buildBillUploadCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Submit Bill & Photos',
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 4.h),
          Text('Tap a tile to pick from gallery, long-press for camera.',
              style: TextStyle(
                  fontSize: 11.sp, color: const Color(0xFF9E9E9E))),
          SizedBox(height: 12.h),
          // Each tile is its own Obx so it rebuilds independently
          Row(
            children: [
              Expanded(
                child: Obx(() => _PhotoTile(
                  label: 'Bill',
                  icon: Icons.receipt_long,
                  imagePath: controller.billImagePath.value,
                  onGallery: controller.pickBillImage,
                  onCamera: controller.pickBillImageFromCamera,
                )),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Obx(() => _PhotoTile(
                  label: 'Before',
                  icon: Icons.history,
                  imagePath: controller.beforePhotoPath.value,
                  onGallery: controller.pickBeforePhoto,
                  onCamera: controller.pickBeforePhotoFromCamera,
                )),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Obx(() => _PhotoTile(
                  label: 'After',
                  icon: Icons.auto_awesome,
                  imagePath: controller.afterPhotoPath.value,
                  onGallery: controller.pickAfterPhoto,
                  onCamera: controller.pickAfterPhotoFromCamera,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ───────────────────────── Bottom Button ───────────────────────
  Widget _buildBottomButton() {
    return Obx(() {
      if (controller.isJobCompleted) return const SizedBox.shrink();

      return Padding(
        padding: EdgeInsets.all(16.w),
        child: GestureDetector(
          onTap: controller.isActionLoading.value
              ? null
              : () {
            print('🔘 [BTN] tapped — status=${controller.jobStatusCode.value}');
            if (controller.isInProgress) {
              controller.submitBill();
            } else {
              controller.advanceStatus();
            }
          },
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: controller.isActionLoading.value
                  ? const Color(0xFFF8C106).withOpacity(0.6)
                  : const Color(0xFFF8C106),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: controller.isActionLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(controller.bottomButtonIcon,
                      color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    controller.bottomButtonLabel,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // ── Shared decoration ─────────────────────────────────────────
  BoxDecoration _card() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.r),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 2))
    ],
  );
}

// ══════════════════════════════════════════════════════════════════
//  Photo Tile widget — tap = gallery, long-press = camera sheet
// ══════════════════════════════════════════════════════════════════
class _PhotoTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String imagePath;
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  const _PhotoTile({
    required this.label,
    required this.icon,
    required this.imagePath,
    required this.onGallery,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath.isNotEmpty;
    return GestureDetector(
      onTap: () => _showSheet(context),
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10.r),
          border: hasImage
              ? Border.all(color: const Color(0xFF43A047), width: 1.5)
              : null,
          image: hasImage
              ? DecorationImage(
              image: FileImage(File(imagePath)), fit: BoxFit.cover)
              : null,
        ),
        child: hasImage
            ? Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.all(4.w),
            padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(
                color: Color(0xFF43A047), shape: BoxShape.circle),
            child:
            Icon(Icons.check, color: Colors.white, size: 10.sp),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22.sp, color: const Color(0xFF9E9E9E)),
            SizedBox(height: 4.h),
            Text(label,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF9E9E9E))),
            SizedBox(height: 2.h),
            Icon(Icons.add_circle_outline,
                size: 14.sp, color: const Color(0xFFBDBDBD)),
          ],
        ),
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(2.r)),
            ),
            SizedBox(height: 16.h),
            Text('Add $label Photo',
                style: TextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            ListTile(
              leading: _sheetIcon(Icons.photo_library_outlined),
              title: Text('Choose from Gallery',
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
                onGallery();
              },
            ),
            ListTile(
              leading: _sheetIcon(Icons.camera_alt_outlined),
              title: Text('Take a Photo',
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
                onCamera();
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _sheetIcon(IconData i) => Container(
    width: 40.w,
    height: 40.w,
    decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10.r)),
    child: Icon(i, color: const Color(0xFF212121), size: 20.sp),
  );
}