import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  bool isThisWeek = true;

  final List<Map<String, dynamic>> transactions = [
    {'id': 'JOB-001', 'date': 'Dec 8', 'amount': '+৳288', 'color': Color(0xFF4CAF50)},
    {'id': 'JOB-002', 'date': 'Dec 8', 'amount': '+৳183', 'color': Color(0xFF4CAF50)},
    {'id': 'JOB-003', 'date': 'Dec 7', 'amount': '-৳405', 'color': Color(0xFFF44336)},
    {'id': 'JOB-004', 'date': 'Dec 8', 'amount': '+৳135', 'color': Color(0xFF4CAF50)},
    {'id': 'JOB-005', 'date': 'Dec 5', 'amount': '+৳252', 'color': Color(0xFF4CAF50)},
  ];

  final List<Map<String, dynamic>> payoutHistory = [
    {'amount': '৳3,500', 'date': 'Dec 3', 'status': 'Completed'},
    {'amount': '৳2,800', 'date': 'Nov 26', 'status': 'Completed'},
    {'amount': '৳4,209', 'date': 'Dec 3', 'status': 'Completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black87),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Earnings',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Total Earnings Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFC107), Color(0xFFFFB300)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC107).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text(
                            'Total earnings',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '৳12,450',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                         SizedBox(height: 8.h),
                          Row(
                            children: [
                              const Icon(Icons.trending_up, color: Colors.white, size: 16),
                              SizedBox(width: 4.w),
                              Text(
                                '+12% more this month',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Week / Month Toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildToggleButton('This Week', isThisWeek, () {
                            setState(() => isThisWeek = true);
                          }),
                          _buildToggleButton('This Month', !isThisWeek, () {
                            setState(() => isThisWeek = false);
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // This Week Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'This Week',
                            '৳2850',
                            const Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildStatCard(
                            'Pending',
                            '৳650',
                            const Color(0xFFF44336),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Platform Commission
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Platform Commission',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '10% per job',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '10%',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFFC107),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.sp),

                    // Recent Transactions
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: transactions.asMap().entries.map((entry) {
                          final i = entry.key;
                          final t = entry.value;
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF8E1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.work_outline, size: 18, color: Color(0xFFFFC107)),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            t['id'],
                                            style:  TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            t['date'],
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      t['amount'],
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: t['color'],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (i < transactions.length - 1)
                                Divider(height: 1, color: Colors.grey[100]),
                            ],
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Bank Account
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.account_balance, size: 18, color: Color(0xFF1976D2)),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Account',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  'Bkash Naquib •••• 452',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Payout History
                    Text(
                      'Payout History',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    ...payoutHistory.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p['amount'],
                                  style:  TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  p['date'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),

                   SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            // Request Withdrawal Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Request Withdrawal',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.w),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFFC107) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}