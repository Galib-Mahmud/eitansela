import 'dart:async';
import 'package:get/get.dart';

import '../../../feature/auth/screen/sign_in_screen.dart';
import '../../../feature/splash/screen/splash_screen.dart';


class SplashController extends GetxController {
  // final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {

      Get.offAll(() => const SignInScreen());

      // String? accessToken = StorageService.accessToken;
      //
      // if (accessToken != null && accessToken.isNotEmpty) {
      //   AppNavigation.pushAndClear(Get.context!, SignInScreen());
      //
      // } else {
      //
      //   // AppNavigation.pushAndClear(Get.context!, OnboardingScreen());
      //   AppNavigation.pushAndClear(Get.context!, HomePage());
      //
      // }
    });
  }

}