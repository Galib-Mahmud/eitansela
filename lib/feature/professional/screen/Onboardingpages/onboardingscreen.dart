import 'package:eitansela/feature/professional/screen/Onboardingpages/setupservices.dart';
import 'package:eitansela/feature/professional/screen/Onboardingpages/verifyidentity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'accrountcreatedonboarding.dart';
import 'applicationsubmitted.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _goHome() {
    setState(() => _currentStep = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
        child: _buildCurrentScreen(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentStep) {
      case 0:
        return Screen1AccountCreated(key: const ValueKey(0), onNext: _nextStep);
      case 1:
        return Screen2VerifyIdentity(key: const ValueKey(1), onNext: _nextStep);
      case 2:
        return Screen3SetupServices(key: const ValueKey(2), onNext: _nextStep);
      case 3:
        return Screen4ApplicationSubmitted(key: const ValueKey(3), onHome: _goHome);
      default:
        return Screen1AccountCreated(key: const ValueKey(0), onNext: _nextStep);
    }
  }
}


// SHARED WIDGETS

const kPrimary = Color(0xFFF5A623);
const kPrimaryLight = Color(0xFFFFF3DC);
const kTextDark = Color(0xFF1A1A1A);
const kTextGrey = Color(0xFF888888);
const kBorderGrey = Color(0xFFE0E0E0);

class StepIndicator extends StatelessWidget {
  final int currentStep; // 0-indexed
  const StepIndicator({super.key, required this.currentStep});

  static const List<String> labels = ['Account', 'Identity', 'Services', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress bar
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
        // Step circles + labels
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
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
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


