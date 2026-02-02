import 'package:eitansela/feature/home/screen/home_screen.dart';
import 'package:eitansela/feature/home/screen/my_request_screen.dart';
import 'package:eitansela/feature/home/screen/my_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eitansela/routes/route_name.dart';

import '../profile/screen/profile_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  final int initialIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    HomeDashboardScreen(),
    MyRequest(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 65.h,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isActive: _currentIndex == 0,
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          _buildNavItem(
            icon: Icons.assignment_outlined,
            activeIcon: Icons.assignment,
            label: 'Bookings',
            isActive: _currentIndex == 1,
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Account',
            isActive: _currentIndex == 2,
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
            },
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