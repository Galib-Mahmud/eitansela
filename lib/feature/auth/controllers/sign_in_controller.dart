import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';
import '../../splash/screen/onboarding_screen2.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signIn() {
    Get.offAll(() => const Onboarding2Screen());
  }

  void goToSignUp() {
    Get.toNamed(RouteName.signup);
  }

  void goToForgotPassword() {
    Get.toNamed(RouteName.forgetPass);
  }

  void continueWithGoogle() {
    // TODO: implement Google sign-in
  }

  void continueWithApple() {
    // TODO: implement Apple sign-in
  }
}