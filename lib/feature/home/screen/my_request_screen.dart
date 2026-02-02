import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRequest extends StatefulWidget {
  const MyRequest({Key? key}) : super(key: key);

  @override
  State<MyRequest> createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  String selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF212121),
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Request',
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
          SizedBox(height: 16.h),
          // Tab Bar
          _buildTabBar(),
          SizedBox(height: 16.h),
          // Request List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _buildRequestCard(
                 IconPath: 'assets/images/profile/water.png',
                  iconColor: const Color(0xFF2196F3),
                  iconBgColor: const Color(0xFFE3F2FD),
                  service: 'Plumbing',
                  date: 'Oct 24, 2025',
                  total: '₦450',
                  distance: '2.3 km',
                  status: 'Completed',
                  statusColor: const Color(0xFF4CAF50),
                  statusBgColor: const Color(0xFFE8F5E9),
                ),
                SizedBox(height: 16.h),
                _buildRequestCard(
                 IconPath: 'assets/images/profile/2.png',
                  iconColor: const Color(0xFFFFA726),
                  iconBgColor: const Color(0xFFFFF3E0),
                  service: 'Electrical',
                  date: 'Oct 24, 2025',
                  total: '₦320',
                  distance: '2.3 km',
                  status: 'Completed',
                  statusColor: const Color(0xFF4CAF50),
                  statusBgColor: const Color(0xFFE8F5E9),
                ),
                SizedBox(height: 16.h),
                _buildRequestCard(
                 IconPath: 'assets/images/profile/water.png',
                  iconColor: const Color(0xFF2196F3),
                  iconBgColor: const Color(0xFFE3F2FD),
                  service: 'Plumbing',
                  date: 'Oct 24, 2025',
                  total: '₦0',
                  distance: '2.3 km',
                  status: 'Cancelled',
                  statusColor: Colors.white,
                  statusBgColor: const Color(0xFFF44336),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _buildTab('All'),
          SizedBox(width: 12.w),
          _buildTab('Active'),
          SizedBox(width: 12.w),
          _buildTab('Completed'),
          SizedBox(width: 12.w),
          _buildTab('Cancelled'),
        ],
      ),
    );
  }

  Widget _buildTab(String label) {
    bool isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00B4A8) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF00B4A8) : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF757575),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required String IconPath,
    required Color iconColor,
    required Color iconBgColor,
    required String service,
    required String date,
    required String total,
    required String distance,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Icon, Service Name, Status
          Row(
            children: [
              // Service Icon
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(IconPath),
              ),
              SizedBox(width: 12.w),
              // Service Name and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF212121),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12.sp,
                          color: const Color(0xFF9E9E9E),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Bottom Row: Total and Distance
          Row(
            children: [
              // Total
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      total,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
              ),
              // Distance
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distance',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: const Color(0xFF9E9E9E),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          distance,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? const Color(0xFF00B4A8) : const Color(0xFF9E9E9E),
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: isActive ? const Color(0xFF00B4A8) : const Color(0xFF9E9E9E),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}