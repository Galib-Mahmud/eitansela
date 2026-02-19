import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onboardingscreen.dart';
class Screen2VerifyIdentity extends StatefulWidget {
  final VoidCallback onNext;
  const Screen2VerifyIdentity({super.key, required this.onNext});

  @override
  State<Screen2VerifyIdentity> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2VerifyIdentity> {
  final List<bool> _uploaded = [false, false, false];

  @override
  Widget build(BuildContext context) {
    final docs = [
      {
        'title': 'Government ID',
        'subtitle': "Driver's license, Passport, or National ID",
        'icon': Icons.badge_outlined,
      },
      {
        'title': 'Professional Certificate',
        'subtitle': 'Trade licenses or relevant certifications',
        'icon': Icons.workspace_premium_outlined,
      },
      {
        'title': 'Profile Photo',
        'subtitle': 'Clear Photo of Your face for customers',
        'icon': Icons.person_outline,
      },
    ];

    int uploadedCount = _uploaded.where((v) => v).length;

    return BaseScreen(
      step: 1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verify Your Identity',
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: kTextDark),
          ),
          SizedBox(height: 6.h),
          Text(
            'Upload required documents to continue',
            style: TextStyle(fontSize: 14.sp, color: kTextGrey),
          ),
          SizedBox(height: 24.h),
          ...List.generate(docs.length, (i) {
            return _DocCard(
              title: docs[i]['title'] as String,
              subtitle: docs[i]['subtitle'] as String,
              icon: docs[i]['icon'] as IconData,
              uploaded: _uploaded[i],
              onChoose: () => setState(() => _uploaded[i] = true),
            );
          }),
          Spacer(),
          Row(
            children: [
              Text('Documents uploaded',
                  style: TextStyle(color: kTextGrey, fontSize: 13.sp)),
              Spacer(),
              Text(
                '$uploadedCount of 3',
                style: TextStyle(
                    color: kTextGrey,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          LinearProgressIndicator(
            value: uploadedCount / 3,
            backgroundColor: kBorderGrey,
            color: kPrimary,
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
          SizedBox(height: 16.h),
        ],
      ),
      bottomButton:
      PrimaryButton(label: 'Continue Setup', onTap: widget.onNext),
    );
  }
}


class _DocCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final bool uploaded;
  final VoidCallback onChoose;

  const _DocCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.uploaded,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        border: Border.all(color: uploaded ? kPrimary : kBorderGrey),
        borderRadius: BorderRadius.circular(12.r),
        color: uploaded ? kPrimaryLight : Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: uploaded ? kPrimary : kTextGrey, size: 28.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp)),
                Text(subtitle,
                    style: TextStyle(fontSize: 12.sp, color: kTextGrey)),
              ],
            ),
          ),
          GestureDetector(
            onTap: onChoose,
            child: Row(
              children: [
                Icon(
                  uploaded ? Icons.check_circle : Icons.upload_outlined,
                  color: kPrimary,
                  size: 18.r,
                ),
                SizedBox(width: 4.w),
                Text(
                  uploaded ? 'Uploaded' : 'Choose',
                  style: TextStyle(
                      color: kPrimary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
