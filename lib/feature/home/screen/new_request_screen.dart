import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/route_name.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({Key? key}) : super(key: key);

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  @override
  void dispose() {
    _descriptionController.dispose();
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
          // Limit to 5 photos
          if (_selectedImages.length + images.length <= 5) {
            _selectedImages.addAll(images);
          } else {
            int remaining = 5 - _selectedImages.length;
            _selectedImages.addAll(images.take(remaining));
            Get.snackbar(
              'Limit Reached',
              'You can only upload up to 5 photos',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange,
              colorText: Colors.white,
              margin: EdgeInsets.all(16.w),
            );
          }
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'New Request',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF212121),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // Step Indicators
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        _buildStepIndicator(
                          number: '1',
                          label: 'Details',
                          isActive: true,
                          isCompleted: false,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE0E0E0),
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                        ),
                        _buildStepIndicator(
                          number: '2',
                          label: 'Diagnosis',
                          isActive: false,
                          isCompleted: false,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE0E0E0),
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                        ),
                        _buildStepIndicator(
                          number: '3',
                          label: 'Confirm',
                          isActive: false,
                          isCompleted: false,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Describe the issue section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Describe the issue',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF212121),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Add Photos Button
                          GestureDetector(
                            onTap: _selectedImages.length < 5 ? _pickImages : null,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: const Color(0xFF00B4A8),
                                    size: 32.sp,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    'Add Photos',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF212121),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Up to 5 photos (JPG, PNG)',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF9E9E9E),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Show selected images
                          if (_selectedImages.isNotEmpty) ...[
                            SizedBox(height: 16.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: _selectedImages.asMap().entries.map((entry) {
                                return Stack(
                                  children: [
                                    Container(
                                      width: 70.w,
                                      height: 70.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: const Color(0xFFE0E0E0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: Image.network(
                                          entry.value.path,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                              size: 30.sp,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4.h,
                                      right: 4.w,
                                      child: GestureDetector(
                                        onTap: () => _removeImage(entry.key),
                                        child: Container(
                                          padding: EdgeInsets.all(4.w),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.6),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],

                          SizedBox(height: 20.h),

                          // Description TextField
                          TextField(
                            controller: _descriptionController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Describe your problem here... (e.g. Water is leaking from under the sink)',
                              hintStyle: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFBDBDBD),
                                fontWeight: FontWeight.w400,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF5F5F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: const Color(0xFF00B4A8),
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(16.w),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF212121),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                if (_selectedImages.isEmpty && _descriptionController.text.isEmpty) {
                  Get.snackbar(
                    'Required',
                    'Please add photos or description',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                    margin: EdgeInsets.all(16.w),
                  );
                  return;
                }
                // Navigate to analysis screen
                Get.toNamed(RouteName.newRequestAnalysis);
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF00B4A8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'Continue to Diagnosis',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator({
    required String number,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF00B4A8) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? const Color(0xFF00B4A8) : const Color(0xFFE0E0E0),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF9E9E9E),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xFF00B4A8) : const Color(0xFF9E9E9E),
          ),
        ),
      ],
    );
  }
}