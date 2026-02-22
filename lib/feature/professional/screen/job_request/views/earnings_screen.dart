import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/earnings_controller.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(EarningsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildHeader(),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTotalEarningsCard(c),
                    SizedBox(height: 14.h),
                    _buildFilterButton(c),
                    SizedBox(height: 14.h),
                    _buildWeekPendingRow(c),
                    SizedBox(height: 20.h),
                    _buildRecentTransactions(c),
                    SizedBox(height: 14.h),
                    _buildBankAccount(),
                    SizedBox(height: 20.h),
                    _buildPayoutHistory(c),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _buildWithdrawButton(c),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── Header ────────────────────────────────
  Widget _buildHeader() {
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
            'Earnings',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── Total Earnings Card ───────────────────
  Widget _buildTotalEarningsCard(EarningsController c) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8C106), Color(0xFFE6A800)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Earnings',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₪',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                c.totalEarnings.value,
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                c.growthPercent.value,
                style: TextStyle(fontSize: 13.sp, color: Colors.white),
              ),
            ],
          ),
        ],
      )),
    );
  }

  // ─────────────────────── Filter Button ─────────────────────────
  Widget _buildFilterButton(EarningsController c) {
    return GestureDetector(
      onTap: () => _showFilterSheet(c),
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF8C106),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              c.selectedFilter.value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20.sp),
          ],
        )),
      ),
    );
  }

  void _showFilterSheet(EarningsController c) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: c.filters
              .map((f) => ListTile(
            title: Text(f,
                style: TextStyle(fontSize: 15.sp, color: const Color(0xFF212121))),
            trailing: Obx(() => c.selectedFilter.value == f
                ? Icon(Icons.check, color: const Color(0xFFF8C106), size: 18.sp)
                : const SizedBox.shrink()),
            onTap: () {
              c.setFilter(f);
              Get.back();
            },
          ))
              .toList(),
        ),
      ),
    );
  }

  // ─────────────────────── This Week / Pending ───────────────────
  Widget _buildWeekPendingRow(EarningsController c) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatBox(
            label: 'This Week',
            value: c.thisWeek.value,
            valueColor: const Color(0xFF43A047),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatBox(
            label: 'Pending',
            value: c.pending.value,
            valueColor: const Color(0xFFF8C106),
          ),
        ),
      ],
    ));
  }

  Widget _buildStatBox({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
          SizedBox(height: 6.h),
          Text(value,
              style: TextStyle(
                  fontSize: 20.sp, fontWeight: FontWeight.w800, color: valueColor)),
        ],
      ),
    );
  }

  // ─────────────────────── Recent Transactions ───────────────────
  Widget _buildRecentTransactions(EarningsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Transactions',
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w800, color: const Color(0xFF212121))),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Obx(() => Column(
            children: List.generate(c.transactions.length, (index) {
              final t = c.transactions[index];
              final isLast = index == c.transactions.length - 1;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.jobId,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF212121))),
                            SizedBox(height: 3.h),
                            Text(t.date,
                                style: TextStyle(
                                    fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                          ],
                        ),
                        Text(
                          t.amount,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF43A047),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                        height: 1,
                        indent: 16.w,
                        endIndent: 16.w,
                        color: const Color(0xFFF0F0F0)),
                ],
              );
            }),
          )),
        ),
      ],
    );
  }

  // ─────────────────────── Bank Account ──────────────────────────
  Widget _buildBankAccount() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.credit_card, color: const Color(0xFF3949AB), size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bank Account',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF212121))),
                SizedBox(height: 3.h),
                Text('Bank Hapoalim •••• 4521',
                    style: TextStyle(fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: const Color(0xFF9E9E9E), size: 20.sp),
        ],
      ),
    );
  }

  // ─────────────────────── Payout History ────────────────────────
  Widget _buildPayoutHistory(EarningsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payout History',
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w800, color: const Color(0xFF212121))),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Obx(() => Column(
            children: List.generate(c.payouts.length, (index) {
              final p = c.payouts[index];
              final isLast = index == c.payouts.length - 1;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.amount,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF212121))),
                            SizedBox(height: 3.h),
                            Text(p.date,
                                style: TextStyle(
                                    fontSize: 12.sp, color: const Color(0xFF9E9E9E))),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            p.status,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF43A047),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                        height: 1,
                        indent: 16.w,
                        endIndent: 16.w,
                        color: const Color(0xFFF0F0F0)),
                ],
              );
            }),
          )),
        ),
      ],
    );
  }

  // ─────────────────────── Withdraw Button ───────────────────────
  Widget _buildWithdrawButton(EarningsController c) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: GestureDetector(
        onTap: c.requestWithdrawal,
        child: Container(
          width: double.infinity,
          height: 54.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF8C106),
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: Text(
            'Request Withdrawal',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}