import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.size = 45,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back,
          color: iconColor,
        ),
      ),
    );
  }
}