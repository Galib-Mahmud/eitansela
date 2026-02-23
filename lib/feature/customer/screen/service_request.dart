import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/route_name.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];
  bool _isEmergency = false;
  bool _canCall = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _addressController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (images.isNotEmpty) {
        setState(() {
          if (_selectedImages.length + images.length <= 5) {
            _selectedImages.addAll(images);
          } else {
            int remaining = 5 - _selectedImages.length;
            _selectedImages.addAll(images.take(remaining));
          }
        });
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            // App bar
            _buildAppBar(),
            SizedBox(height: 12.h),
            Divider(color: const Color(0xFFEEEEEE), thickness: 1, height: 1),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Describe your Problem
                    _buildSectionTitle('Describe your Problem'),
                    SizedBox(height: 10.h),
                    _buildDescriptionField(),

                    SizedBox(height: 24.h),

                    // Upload Files
                    _buildSectionTitle('Upload Files'),
                    SizedBox(height: 10.h),
                    _buildUploadArea(),

                    SizedBox(height: 24.h),

                    // Address
                    _buildSectionTitle('Address'),
                    SizedBox(height: 10.h),
                    _buildInputField(
                      controller: _addressController,
                      hintText: 'Street and House Address...',
                      iconPath: 'assets/images/request/location_icon.png',
                      iconFallback: Icons.location_on,
                      iconColor: const Color(0xFFE53935),
                    ),

                    SizedBox(height: 24.h),

                    // Zip Code
                    _buildSectionTitle('Zip Code'),
                    SizedBox(height: 10.h),
                    _buildInputField(
                      controller: _zipController,
                      hintText: '1234',
                      iconPath: 'assets/images/request/zip_icon.png',
                      iconFallback: Icons.flag,
                      iconColor: const Color(0xFFE53935),
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 24.h),

                    // Phone Number
                    _buildSectionTitle('Phone Number'),
                    SizedBox(height: 10.h),
                    _buildInputField(
                      controller: _phoneController,
                      hintText: '1233453546546',
                      iconPath: 'assets/images/request/phone_icon.png',
                      iconFallback: Icons.phone,
                      iconColor: const Color(0xFF424242),
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 20.h),

                    // Emergency Service
                    buildNoCallCard(),
                    SizedBox(height: 20.h),
                    _buildNoCallCard(),
                    SizedBox(height: 24.h),
                    // Continue button
                    _buildContinueButton(),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── App Bar ─────────────────────────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: const Color(0xFF212121),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Service Request',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────── Section Title ───────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF212121),
      ),
    );
  }

  // ───────────────────── Description Field ───────────────────────────
  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 2,
      decoration: InputDecoration(
        hintText: 'Tell us what you need help with..',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFFBDBDBD),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFF8C106), width: 1.5),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF212121)),
    );
  }

  // ───────────────────── Upload Area (Dashed Border) ────────────────
  Widget _buildUploadArea() {
    return GestureDetector(
      onTap: _selectedImages.length < 5 ? _pickImages : null,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: const Color(0xFFF8C106),
          strokeWidth: 1.5,
          borderRadius: 14.r,
          dashWidth: 8,
          dashSpace: 5,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Column(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: const Color(0xFFF8C106),
                size: 32.sp,
              ),
              SizedBox(height: 10.h),
              Text(
                'Tap to capture or upload',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'JPG, PNG (max 10MB)',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────── Input Field ─────────────────────────────────
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    required IconData iconFallback,
    required Color iconColor,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFFBDBDBD),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(
            iconFallback,
            color: iconColor,
            size: 22.sp,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFF8C106), width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      ),
      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF212121)),
    );
  }


  Widget buildNoCallCard() {
    return GestureDetector(
      onTap: () => setState(() => _canCall = !_canCall),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFBDBDBD),
            width: 1,
          ),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: _canCall
                      ? const Color(0xFFF8C106)
                      : const Color(0xFFBDBDBD),
                  width: 2,
                ),
                color: _canCall ? const Color(0xFFF8C106) : Colors.white,
              ),
              child: _canCall
                  ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                      children: [
                        const TextSpan(text: 'Mark as Emergency Service '),
                        TextSpan(
                          text: '(+€30)',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Get priority placement and faster response times from providers',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Emergency Card ──────────────────────────────
  Widget _buildNoCallCard() {
    return GestureDetector(
      onTap: () => setState(() => _isEmergency = !_isEmergency),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _isEmergency
              ? const Color(0xFFFFEBEE)
              : const Color(0xFFFFEBEE).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFFEF5350),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: _isEmergency
                      ? const Color(0xFFF8C106)
                      : const Color(0xFFBDBDBD),
                  width: 2,
                ),
                color: _isEmergency ? const Color(0xFFF8C106) : Colors.white,
              ),
              child: _isEmergency
                  ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                      children: [
                        const TextSpan(text: 'Mark as Emergency Service '),
                        TextSpan(
                          text: '(+€30)',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Get priority placement and faster response times from providers',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Continue Button ─────────────────────────────
  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteName.newRequestAnalysis);
      },
      child: Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF8C106),
          borderRadius: BorderRadius.circular(27.r),
        ),
        child: Center(
          child: Text(
            'Continue to Diagnosis',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────── Dashed Border Painter ───────────────────────────────
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.borderRadius,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rRect);
    final PathMetrics pathMetrics = path.computeMetrics();

    for (final PathMetric metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final double end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}