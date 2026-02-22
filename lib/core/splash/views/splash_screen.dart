import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body:  Center(
        child: Image.asset(
          "assets/images/splash/onboarding.png",
          width: MediaQuery.sizeOf(context).width,
          height:250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
