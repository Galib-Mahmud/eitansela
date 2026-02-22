import 'package:eitansela/feature/professional/screen/Onboardingpages/setupservices.dart';
import 'package:eitansela/feature/professional/screen/Onboardingpages/verifyidentity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'accrountcreatedonboarding.dart';
import 'applicationsubmitted.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/route_name.dart'; // adjust to your project

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _goHome() {
    Get.toNamed(RouteName.main1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // disable manual swipe
        onPageChanged: (index) => setState(() => _currentStep = index),
        children: [
          Screen1AccountCreated(onNext: _nextStep),
          Screen2VerifyIdentity(onNext: _nextStep),
          Screen3SetupServices(onNext: _nextStep),
          Screen4ApplicationSubmitted(onHome: _goHome),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────
// SHARED CONSTANTS & WIDGETS (unchanged)
// ───────────────────────────────────────────────────────────────────

const kPrimary = Color(0xFFF5A623);
const kPrimaryLight = Color(0xFFFFF3DC);
const kTextDark = Color(0xFF1A1A1A);
const kTextGrey = Color(0xFF888888);
const kBorderGrey = Color(0xFFE0E0E0);

class StepIndicator extends StatelessWidget {
  final int currentStep;
  const StepIndicator({super.key, required this.currentStep});

  static const List<String> labels = ['Account', 'Identity', 'Services', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 3 ? 4.w : 0),
                height: 4.h,
                decoration: BoxDecoration(
                  color: i <= currentStep ? kPrimary : kBorderGrey,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (i) {
            final isActive = i <= currentStep;
            return Column(
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: isActive ? kPrimary : kBorderGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : kTextGrey,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isActive ? kPrimary : kTextGrey,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class BaseScreen extends StatelessWidget {
  final int step;
  final Widget body;
  final Widget bottomButton;
  const BaseScreen({
    super.key,
    required this.step,
    required this.body,
    required this.bottomButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepIndicator(currentStep: step),
            SizedBox(height: 24.h),
            Expanded(child: body),
            bottomButton,
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}