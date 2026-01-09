import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed});

  static const Color primary = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary, // Use the defined primary color
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(style: TextStyle(color: Colors.white,fontSize: 16.sp,fontFamily: 'Poppins'),text),
      ),
    );
  }
}