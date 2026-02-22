import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScheduleConfirmationScreen extends StatefulWidget {
  const ScheduleConfirmationScreen({super.key});

  @override
  State<ScheduleConfirmationScreen> createState() =>
      _ScheduleConfirmationScreenState();
}

class _ScheduleConfirmationScreenState
    extends State<ScheduleConfirmationScreen> {
  int _selectedLocation = 0;
  int _selectedTiming = 0;
  DateTime? _selectedDate;
  int _selectedHour = 10;
  int _selectedMinute = 0;
  String _selectedPeriod = 'AM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),

              Text(
                'Where is the problem?',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF212121),
                ),
              ),

              SizedBox(height: 16.h),

              // Map
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/auth/location.png',
                      width: double.infinity,
                      height: 220.h,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 40.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, color: const Color(0xFFF8C106), size: 18.sp),
                              SizedBox(width: 6.w),
                              Text(
                                'Dizengoff St 12, Tel Aviv',
                                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF212121)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              _buildLocationCard(index: 0, title: 'Home', address: 'Dizengoff St 12, Tel Aviv'),
              SizedBox(height: 12.h),
              _buildLocationCard(index: 1, title: 'Office', address: 'Rothschild Blvd 45, Tel Aviv'),

              SizedBox(height: 20.h),

              // Timing cards - IntrinsicHeight for equal size
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _buildTimingCard(index: 0, icon: Icons.access_time_rounded, title: 'Immediately', subtitle: 'Professional arrives in ~45 mins')),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildTimingCard(index: 1, icon: Icons.calendar_today_outlined, title: 'Schedule', subtitle: 'Pick a date & time')),
                  ],
                ),
              ),

              // Selected date display
              if (_selectedTiming == 1 && _selectedDate != null) ...[
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.event, color: const Color(0xFFF8C106), size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}  $_selectedHour:${_selectedMinute.toString().padLeft(2, '0')} $_selectedPeriod',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF212121)),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 28.h),

              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteName.confirmReq);
                },


                child: Container(
                  width: double.infinity,
                  height: 54.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8C106),
                    borderRadius: BorderRadius.circular(27.r),
                  ),
                  child: Center(
                    child: Text('Continue', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────── Location Card ───────────────────────────────
  Widget _buildLocationCard({required int index, required String title, required String address}) {
    final bool isSelected = _selectedLocation == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedLocation = index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFF8C106) : const Color(0xFFE8E8E8),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFF8E1) : const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.location_on_outlined, color: isSelected ? const Color(0xFFF8C106) : const Color(0xFFBDBDBD), size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121))),
                  SizedBox(height: 2.h),
                  Text(address, style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                ],
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? const Color(0xFFF8C106) : const Color(0xFFD0D0D0), width: 2),
              ),
              child: isSelected
                  ? Center(child: Container(width: 12.w, height: 12.w, decoration: const BoxDecoration(color: Color(0xFFF8C106), shape: BoxShape.circle)))
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Timing Card ─────────────────────────────────
  Widget _buildTimingCard({required int index, required IconData icon, required String title, required String subtitle}) {
    final bool isSelected = _selectedTiming == index;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTiming = index);
        if (index == 1) _showDatePickerSheet();
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF8E1) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFF8C106) : const Color(0xFFE8E8E8),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF8C106) : const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? Colors.white : const Color(0xFFBDBDBD), size: 20.sp),
            ),
            SizedBox(height: 12.h),
            Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121))),
            SizedBox(height: 4.h),
            Text(subtitle, style: TextStyle(fontSize: 11.sp, color: const Color(0xFF9E9E9E))),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Date Picker Sheet ───────────────────────────
  void _showDatePickerSheet() {
    DateTime displayMonth = DateTime.now();
    int tempDay = DateTime.now().day;
    int tempHour = _selectedHour;
    int tempMinute = _selectedMinute;
    String tempPeriod = _selectedPeriod;

    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheet) {
            final daysInMonth = DateUtils.getDaysInMonth(displayMonth.year, displayMonth.month);
            final firstWeekday = DateTime(displayMonth.year, displayMonth.month, 1).weekday % 7;

            return Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12.h),
                    // Handle bar
                    Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(2.r))),
                    SizedBox(height: 8.h),

                    // Close
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(ctx),
                        child: Icon(Icons.close, color: const Color(0xFFBDBDBD), size: 24.sp),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Month nav
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => setSheet(() => displayMonth = DateTime(displayMonth.year, displayMonth.month - 1)),
                          child: Icon(Icons.chevron_left, color: const Color(0xFFBDBDBD), size: 28.sp),
                        ),
                        Text(
                          '${monthNames[displayMonth.month - 1]} ${displayMonth.year}',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)),
                        ),
                        GestureDetector(
                          onTap: () => setSheet(() => displayMonth = DateTime(displayMonth.year, displayMonth.month + 1)),
                          child: Icon(Icons.chevron_right, color: const Color(0xFFBDBDBD), size: 28.sp),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Day headers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
                          .map((d) => SizedBox(
                        width: 36.w,
                        child: Center(child: Text(d, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: const Color(0xFFBDBDBD)))),
                      ))
                          .toList(),
                    ),

                    SizedBox(height: 6.h),

                    // Calendar grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1.3),
                      itemCount: firstWeekday + daysInMonth,
                      itemBuilder: (context, index) {
                        if (index < firstWeekday) return const SizedBox.shrink();
                        final day = index - firstWeekday + 1;
                        final isSelected = day == tempDay;
                        return GestureDetector(
                          onTap: () => setSheet(() => tempDay = day),
                          child: Center(
                            child: Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFF8C106) : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFF616161),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 8.h),
                    Container(height: 1, color: const Color(0xFFEEEEEE)),
                    SizedBox(height: 14.h),

                    // Time picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeBox(value: tempHour.toString().padLeft(2, '0'), isYellow: true, onTap: () {
                          _showNumberPicker(ctx, List.generate(12, (i) => i + 1), tempHour, (v) => setSheet(() => tempHour = v));
                        }),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 6.w), child: Text(':', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)))),
                        _buildTimeBox(value: tempMinute.toString().padLeft(2, '0'), isYellow: false, onTap: () {
                          _showNumberPicker(ctx, [0, 15, 30, 45], tempMinute, (v) => setSheet(() => tempMinute = v));
                        }),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 6.w), child: Text(':', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: const Color(0xFF212121)))),
                        _buildTimeBox(value: tempPeriod, isYellow: false, onTap: () => setSheet(() => tempPeriod = tempPeriod == 'AM' ? 'PM' : 'AM')),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Confirm
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime(displayMonth.year, displayMonth.month, tempDay);
                          _selectedHour = tempHour;
                          _selectedMinute = tempMinute;
                          _selectedPeriod = tempPeriod;
                        });
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(color: const Color(0xFFF8C106), borderRadius: BorderRadius.circular(25.r)),
                        child: Center(child: Text('Confirm', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white))),
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ───────────────── Time Box ────────────────────────────────────────
  Widget _buildTimeBox({required String value, required bool isYellow, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: isYellow ? Colors.white : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: isYellow ? const Color(0xFFF8C106) : const Color(0xFFE0E0E0), width: isYellow ? 1.5 : 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: const Color(0xFF212121))),
            SizedBox(width: 2.w),
            Icon(Icons.keyboard_arrow_down, size: 14.sp, color: const Color(0xFF616161)),
          ],
        ),
      ),
    );
  }

  // ───────────────── Number Picker ───────────────────────────────────
  void _showNumberPicker(BuildContext context, List<int> items, int current, Function(int) onSelected) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      builder: (ctx) {
        return SizedBox(
          height: 220.h,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              final item = items[index];
              final isSelected = item == current;
              return ListTile(
                title: Center(
                  child: Text(
                    item.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 18.sp, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? const Color(0xFFF8C106) : const Color(0xFF212121)),
                  ),
                ),
                onTap: () {
                  onSelected(item);
                  Navigator.pop(ctx);
                },
              );
            },
          ),
        );
      },
    );
  }
}