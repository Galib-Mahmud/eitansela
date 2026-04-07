// lib/feature/auth/controllers/auth_controller.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';

class AuthController extends GetxController {
  // ─── permanent: true ──────────────────────────────────────────────
  // Keeps controller alive across Get.offAllNamed() route clears.
  // Prevents TextEditingController disposal crash on route rebuild.
  static AuthController get to => Get.put(AuthController(), permanent: true);

  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading = false.obs;

  // OTP flow type: 'register' | 'forgot_password'
  final RxString otpFlowType = 'register'.obs;

  // ─── OTP Timer ────────────────────────────────────────────────────
  final RxInt otpTimerSeconds = 60.obs;
  final RxBool canResend = false.obs;
  Timer? _otpTimer;

  // ─── Role Selection ───────────────────────────────────────────────
  // null = not selected yet; 'PROVIDER' | 'CUSTOMER'
  final Rx<String?> selectedRole = Rx<String?>(null);

  // ─── SignUp Controllers ───────────────────────────────────────────
  final fullNameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final phoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpRePasswordController = TextEditingController();

  // ─── SignIn Controllers ───────────────────────────────────────────
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ─── Forgot Password Controllers ─────────────────────────────────
  final forgotEmailController = TextEditingController();

  // ─── Reset Password Controllers ───────────────────────────────────
  final newPasswordController = TextEditingController();
  final reNewPasswordController = TextEditingController();

  // ─── OTP Controllers ─────────────────────────────────────────────
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());

  // ─── Password Visibility ─────────────────────────────────────────
  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  // ─────────────────────────────────────────────────────────────────
  // OTP TIMER
  // ─────────────────────────────────────────────────────────────────
  void startOtpTimer() {
    _otpTimer?.cancel();
    otpTimerSeconds.value = 60;
    canResend.value = false;

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerSeconds.value > 0) {
        otpTimerSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  String get otpTimerLabel {
    final m = (otpTimerSeconds.value ~/ 60).toString().padLeft(1, '0');
    final s = (otpTimerSeconds.value % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  final RxBool isSignUpPasswordVisible = false.obs;
  final RxBool isSignUpRePasswordVisible = false.obs;

  void toggleSignUpPasswordVisibility() {
    isSignUpPasswordVisible.value = !isSignUpPasswordVisible.value;
  }

  void toggleSignUpRePasswordVisibility() {
    isSignUpRePasswordVisible.value =
    !isSignUpRePasswordVisible.value;
  }

  // ─────────────────────────────────────────────────────────────────
  // ROLE SELECTION
  // ─────────────────────────────────────────────────────────────────
  void selectRole(String role) {
    selectedRole.value = role;
  }

  // ─────────────────────────────────────────────────────────────────
  // REGISTER
  // POST /auth/register/
  // Body: full_name, email, phone_number, password, re_password, role
  // Response: user{}, refresh, access, otp_debug, message
  // ─────────────────────────────────────────────────────────────────
  Future<void> register() async {
    if (fullNameController.text.trim().isEmpty ||
        signUpEmailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        signUpPasswordController.text.isEmpty ||
        signUpRePasswordController.text.isEmpty) {
      _showError('Please fill all required fields');
      return;
    }
    if (selectedRole.value == null) {
      _showError('Please select your role (Provider or Customer)');
      return;
    }
    if (signUpPasswordController.text != signUpRePasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    isLoading.value = true;
    try {
      await _apiClient.post(
        ApiEndpoint.register,
        body: {
          'full_name': fullNameController.text.trim(),
          'email': signUpEmailController.text.trim(),
          'phone_number': phoneController.text.trim(),
          'password': signUpPasswordController.text.trim(),
          're_password': signUpRePasswordController.text.trim(),
          'role': selectedRole.value,
        },
        requiresAuth: false,
      );

      // Store email for OTP verification step
      await UserInfo.setUserEmail(signUpEmailController.text.trim());
      otpFlowType.value = 'register';
      _clearOtpFields();
      startOtpTimer();
      Get.toNamed(RouteName.otpVerification);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ Register error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // VERIFY OTP (dispatcher)
  // ─────────────────────────────────────────────────────────────────
  Future<void> verifyOtp() async {
    if (otpFlowType.value == 'register') {
      await _verifyRegistrationOtp();
    } else if (otpFlowType.value == 'forgot_password') {
      await _verifyForgotPasswordOtp();
    }
  }

  // POST /auth/verify-otp/
  // Body: email, code
  // Response: message, is_active
  Future<void> _verifyRegistrationOtp() async {
    final code = _getOtpCode();
    if (code.length < 6) {
      _showError('Please enter the complete 6-digit code');
      return;
    }
    isLoading.value = true;
    try {
      final email = await UserInfo.getUserEmail();
      await _apiClient.post(
        ApiEndpoint.verifyOtp,
        body: {'email': email, 'code': code},
        requiresAuth: false,
      );
      _otpTimer?.cancel();
      Get.offAllNamed(RouteName.signin);
      _showSuccess('Account verified! Please sign in.');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ VerifyOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // RESEND OTP (dispatcher)
  // ─────────────────────────────────────────────────────────────────
  Future<void> resendOtp() async {
    if (!canResend.value) return;
    if (otpFlowType.value == 'register') {
      await _resendRegistrationOtp();
    } else if (otpFlowType.value == 'forgot_password') {
      await _resendForgotPasswordOtp();
    }
  }

  // POST /auth/forgot-password/ reused for resend registration OTP
  Future<void> _resendRegistrationOtp() async {
    final email = await UserInfo.getUserEmail();
    if (email == null) return;
    isLoading.value = true;
    try {
      await _apiClient.post(
        ApiEndpoint.register,
        body: {'email': email},
        requiresAuth: false,
      );
      startOtpTimer();
      _showSuccess('A new code has been sent to your email');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ResendOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // LOGIN
  // POST /auth/login/
  // Body: email, password
  // Response: refresh, access, user{}
  // ─────────────────────────────────────────────────────────────────
  Future<void> signIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showError('Please enter your email and password');
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiEndpoint.login,
        body: {
          'email': emailController.text.trim(),
          'password': passwordController.text,
        },
        requiresAuth: false,
      );
      if (response != null) {
        await UserInfo.setAccessToken(response['access'] ?? '');
        await UserInfo.setRefreshToken(response['refresh'] ?? '');
      }
      // Flush SharedPreferences before navigating
      await Future.delayed(Duration.zero);
      Get.offAllNamed(RouteName.home);
    } on UnauthorizedException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? 'Invalid email or password');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ Login error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // FORGOT PASSWORD
  // POST /auth/forgot-password/
  // Body: email
  // Response: message
  // ─────────────────────────────────────────────────────────────────
  Future<void> forgotPassword() async {
    if (forgotEmailController.text.trim().isEmpty) {
      _showError('Please enter your email address');
      return;
    }
    isLoading.value = true;
    try {
      await _apiClient.post(
        ApiEndpoint.forgotPassword,
        body: {'email': forgotEmailController.text.trim()},
        requiresAuth: false,
      );
      await UserInfo.setForgotPasswordEmail(forgotEmailController.text.trim());
      otpFlowType.value = 'forgot_password';
      _clearOtpFields();
      startOtpTimer();
      Get.toNamed(RouteName.otpVerification);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ForgotPassword error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // POST /auth/verify-reset-otp/
  // Body: email, code
  // Response: message
  Future<void> _verifyForgotPasswordOtp() async {
    final code = _getOtpCode();
    if (code.length < 6) {
      _showError('Please enter the complete 6-digit code');
      return;
    }
    isLoading.value = true;
    try {
      final email = await UserInfo.getForgotPasswordEmail();
      await _apiClient.post(
        ApiEndpoint.verifyResetOtp,
        body: {'email': email, 'code': code},
        requiresAuth: false,
      );
      // Store OTP code — needed in reset-password body
      await UserInfo.setResetToken(code);
      _otpTimer?.cancel();
      Get.toNamed(RouteName.resetPass);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ VerifyForgotOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // POST /auth/forgot-password/ reused for resend forgot OTP
  Future<void> _resendForgotPasswordOtp() async {
    final email = await UserInfo.getForgotPasswordEmail();
    if (email == null) return;
    isLoading.value = true;
    try {
      await _apiClient.post(
        ApiEndpoint.forgotPassword,
        body: {'email': email},
        requiresAuth: false,
      );
      startOtpTimer();
      _showSuccess('A new code has been sent to your email');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ResendForgotOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // RESET PASSWORD
  // POST /auth/reset-password/
  // Body: email, code, new_password, re_new_password
  // ─────────────────────────────────────────────────────────────────
  Future<void> resetPassword() async {
    if (newPasswordController.text.isEmpty ||
        reNewPasswordController.text.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }
    if (newPasswordController.text != reNewPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }
    if (newPasswordController.text.length < 8) {
      _showError('Password must be at least 8 characters');
      return;
    }
    isLoading.value = true;
    try {
      final email = await UserInfo.getForgotPasswordEmail();
      final code = await UserInfo.getResetToken(); // stored OTP code
      await _apiClient.post(
        ApiEndpoint.resetPassword,
        body: {
          'email': email,
          'code': code,
          'new_password': newPasswordController.text,
          're_new_password': reNewPasswordController.text,
        },
        requiresAuth: false,
      );
      await UserInfo.clearForgotPasswordEmail();
      await UserInfo.clearResetToken();
      _showSuccess('Password reset successfully. Please sign in.');
      Get.offAllNamed(RouteName.resetPassSucess);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ResetPassword error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  // LOGOUT
  // ─────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await UserInfo.clearAll();
    Get.offAllNamed(RouteName.signin);
  }

  // ─────────────────────────────────────────────────────────────────
  // NAVIGATION HELPERS  (called from SignInScreen)
  // ─────────────────────────────────────────────────────────────────
  void goToForgotPassword() => Get.toNamed(RouteName.forgetPass);
  void goToSignUp() => Get.toNamed(RouteName.signup);
  void continueWithGoogle() {
    // TODO: implement Google Sign-In
    _showInfo('Google sign-in coming soon');
  }
  void continueWithApple() {
    // TODO: implement Apple Sign-In
    _showInfo('Apple sign-in coming soon');
  }

  // ─────────────────────────────────────────────────────────────────
  // PARSERS
  // ─────────────────────────────────────────────────────────────────
  Map<String, dynamic>? _tryParseBody(String? body) {
    if (body == null || body.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
    return null;
  }

  String? _extractMessage(Map<String, dynamic>? body) {
    if (body == null) return null;
    if (body.containsKey('detail')) return body['detail'].toString();
    if (body.containsKey('message')) return body['message'].toString();
    for (final entry in body.entries) {
      final val = entry.value;
      if (val is Map && val.containsKey('message')) return val['message'].toString();
      if (val is List && val.isNotEmpty) return val.first.toString();
      if (val is String) return val;
    }
    return null;
  }

  // ─────────────────────────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────────────────────────
  String _getOtpCode() => otpControllers.map((c) => c.text).join('');

  void _clearOtpFields() {
    for (var c in otpControllers) c.clear();
  }

  // ─────────────────────────────────────────────────────────────────
  // SNACKBARS
  // ─────────────────────────────────────────────────────────────────
  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 5),
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  void _showInfo(String message) {
    Get.snackbar(
      "Info",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.shade700,
      colorText: Colors.white,
      icon: const Icon(Icons.info_outline, color: Colors.white),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 4),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // onClose — only cancel the timer, NEVER dispose TextControllers
  // ─────────────────────────────────────────────────────────────────
  // permanent: true keeps this alive for the full app session.
  // Disposing controllers here would cause "used after dispose" crashes
  // the next time any auth screen renders.
  @override
  void onClose() {
    _otpTimer?.cancel();
    super.onClose();
  }
}