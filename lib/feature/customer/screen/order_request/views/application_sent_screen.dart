import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../routes/route_name.dart';

class ApplicationSentScreen extends StatefulWidget {
  const ApplicationSentScreen({super.key});

  @override
  State<ApplicationSentScreen> createState() => _ApplicationSentScreenState();
}

class _ApplicationSentScreenState extends State<ApplicationSentScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-open the Direct Hire sheet after the first frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDirectHireSheet();
    });
  }

  void _showDirectHireSheet() {
    Get.bottomSheet(
      const _DirectHireSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 48.h),

              // ── Green check icon ──────────────────────────────────
              Container(
                width: 82.w,
                height: 82.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCF5E0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 58.w,
                    height: 58.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA5D6A7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: const Color(0xFF2E7D32), size: 28.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // ── Title & subtitle ──────────────────────────────────
              Text(
                'Application Sent!',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF212121),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Your request has been submitted. Here's\nwhat happens next.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF9E9E9E),
                  height: 1.6,
                ),
              ),
              SizedBox(height: 28.h),

              // ── What happens next card ────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What happens next',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildNextStep(
                      icon: Icons.auto_awesome,
                      iconColor: const Color(0xFFF8C106),
                      iconBg: const Color(0xFFFFF8E1),
                      title: 'Automated Matching',
                      subtitle:
                      'Our system is finding the best plumbers in your area based on your zip code and issue type.',
                    ),
                    _buildDivider(),
                    _buildNextStep(
                      icon: Icons.email_outlined,
                      iconColor: const Color(0xFF5C6BC0),
                      iconBg: const Color(0xFFE8EAF6),
                      title: 'Request Emailed to Providers',
                      subtitle:
                      'A limited number of matching service providers will receive your request with a link to your media.',
                    ),
                    _buildDivider(),
                    _buildNextStep(
                      icon: Icons.people_outline,
                      iconColor: const Color(0xFF7E57C2),
                      iconBg: const Color(0xFFEDE7F6),
                      title: 'Providers Respond',
                      subtitle:
                      'Interested providers will reach out to you directly with their quote and availability.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // ── Your Request summary ──────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Request',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    _buildSummaryRow('Issue', 'Burst Pipe (Under Sink)'),
                    SizedBox(height: 10.h),
                    _buildSummaryRow('Professional', 'Plumber'),
                    SizedBox(height: 10.h),
                    _buildSummaryRow('Providers Notified', 'Up to 5 nearby'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // ── Free & non-binding notice ─────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.verified_user_outlined,
                        color: const Color(0xFF43A047), size: 20.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Free & non-binding — you're under no obligation to accept any quote.",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF43A047),
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              // ── Done button ───────────────────────────────────────
              GestureDetector(
                onTap: () => Get.offAllNamed(RouteName.home),
                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8C106),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────── helpers ────────────────────────────────────────
  Widget _buildNextStep({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20.sp),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF212121))),
              SizedBox(height: 4.h),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF9E9E9E),
                      height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() => Padding(
    padding: EdgeInsets.symmetric(vertical: 14.h),
    child: const Divider(color: Color(0xFFEEEEEE), height: 1),
  );

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9E9E9E))),
        Text(value,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF212121))),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  Direct Hire Bottom Sheet
// ═══════════════════════════════════════════════════════════════════
class _DirectHireSheet extends StatelessWidget {
  const _DirectHireSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 36.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Lightning bolt icon ───────────────────────────────────
          Container(
            width: 68.w,
            height: 68.w,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.bolt, color: const Color(0xFFF8C106), size: 32.sp),
          ),
          SizedBox(height: 18.h),

          // ── Title ─────────────────────────────────────────────────
          Text(
            'Direct Hire a Professional',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF212121),
            ),
          ),
          SizedBox(height: 10.h),

          // ── Subtitle ──────────────────────────────────────────────
          Text(
            "Don't want to wait? Browse verified professionals in your area and hire directly — fast, trusted, and hassle-free.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9E9E9E),
              height: 1.6,
            ),
          ),
          SizedBox(height: 22.h),

          // ── Check items ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              children: [
                _buildCheckItem('Instant access to nearby professionals'),
                SizedBox(height: 12.h),
                _buildCheckItem('All providers are verified & trusted'),
                SizedBox(height: 12.h),
                _buildCheckItem('Skip the wait — hire on your schedule'),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // ── Find Professional Now button ──────────────────────────
          GestureDetector(
            onTap: () {
              Get.back();
              Get.toNamed(RouteName.professional);
            },
            child: Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF8C106),
                borderRadius: BorderRadius.circular(30.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'Find Professional Now',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),

          // ── Maybe Later ───────────────────────────────────────────
          GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              'Maybe Later',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      children: [
        Container(
          width: 26.w,
          height: 26.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFF8C106), width: 1.5),
          ),
          child: Icon(Icons.check, color: const Color(0xFFF8C106), size: 14.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF212121),
            ),
          ),
        ),
      ],
    );
  }
}