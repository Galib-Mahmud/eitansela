import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onboardingscreen.dart';
class Screen3SetupServices extends StatefulWidget {
  final VoidCallback onNext;
   Screen3SetupServices({super.key, required this.onNext});

  @override
  State<Screen3SetupServices> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3SetupServices> {
  final Set<String> _selected = {};
  bool _isHourly = true;
  double _radius = 15;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Plumbing', 'icon': '💧'},
    {'name': 'Electrical', 'icon': '⚡'},
    {'name': 'Ac & HVAC', 'icon': '❄️'},
    {'name': 'Painting', 'icon': '🎨'},
    {'name': 'Moving', 'icon': '🚚'},
    {'name': 'Gardening', 'icon': '🌿'},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      step: 2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Up your services',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: kTextDark,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Tell us what service You offer',
              style: TextStyle(fontSize: 14.sp, color: kTextGrey),
            ),
            SizedBox(height: 20.h),
            Text(
              'Select categories',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: kTextDark),
            ),
            SizedBox(height: 12.h),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.1,
              children: _categories.map((cat) {
                final isSelected = _selected.contains(cat['name']);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selected.remove(cat['name']);
                      } else {
                        _selected.add(cat['name'] as String);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isSelected ? kPrimary : kBorderGrey,
                          width: isSelected ? 2.w : 1.w),
                      borderRadius: BorderRadius.circular(12.r),
                      color: isSelected ? kPrimaryLight : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cat['icon'] as String,
                          style: TextStyle(fontSize: 28.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          cat['name'] as String,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? kPrimary : kTextDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.h),
            Text(
              'Pricing',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: kTextDark),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: kBorderGrey),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isHourly = true),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            margin: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: _isHourly ? kPrimary : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Hourly Rate',
                              style: TextStyle(
                                color: _isHourly ? Colors.white : kTextGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isHourly = false),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            margin: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: !_isHourly ? kPrimary : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Price Range',
                              style: TextStyle(
                                color: !_isHourly ? Colors.white : kTextGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Text('\$',
                              style: TextStyle(
                                  color: kPrimary, fontSize: 16.sp)),
                          SizedBox(width: 4.w),
                          Text('0.00',
                              style: TextStyle(
                                  color: kPrimary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600)),
                          Spacer(),
                          Text(_isHourly ? '/hour' : '/job',
                              style: TextStyle(
                                  color: kTextGrey, fontSize: 13.sp)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Service Area',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: kTextDark),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                border: Border.all(color: kBorderGrey),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: kPrimary, size: 18.sp),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Radius: ${_radius.toInt()} Km',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                          Text('Coverage area from your location',
                              style: TextStyle(
                                  color: kTextGrey, fontSize: 12.sp)),
                        ],
                      ),
                    ],
                  ),
                  Slider(
                    value: _radius,
                    min: 5,
                    max: 50,
                    divisions: 9,
                    activeColor: kPrimary,
                    inactiveColor: kBorderGrey,
                    onChanged: (v) => setState(() => _radius = v),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5 km', style: TextStyle(fontSize: 11.sp, color: kTextGrey)),
                      Text('15', style: TextStyle(fontSize: 11.sp, color: kPrimary, fontWeight: FontWeight.bold)),
                      Text('25 km', style: TextStyle(fontSize: 11.sp, color: kTextGrey)),
                      Text('50 km', style: TextStyle(fontSize: 11.sp, color: kTextGrey)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomButton: PrimaryButton(label: 'Submit Application', onTap: widget.onNext),
    );
  }
}
