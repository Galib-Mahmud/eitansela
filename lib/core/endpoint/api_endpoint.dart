// lib/core/endpoint/api_endpoint.dart

class ApiEndpoint {
  // localhost works fine here
  static const String baseUrl = 'https://handyapi.dsrt321.online/api';
  // static const String baseUrl = "http://127.0.0.1:8000";

  // ─── Auth - Registration ───────────────────────────────────────────
  static const String register  = "/auth/register/";
  static const String verifyOtp = "/auth/verify-otp/";

  // ─── Auth - Login ──────────────────────────────────────────────────
  static const String login     = "/auth/login/";

  // ─── Auth - Forgot / Reset Password ───────────────────────────────
  static const String forgotPassword  = "/auth/forgot-password/";
  static const String verifyResetOtp  = "/auth/verify-reset-otp/";
  static const String resetPassword   = "/auth/reset-password/";

  // ─── Auth - Profile ────────────────────────────────────────────────
  static const String profile   = "/auth/profile/";


// AI
  static const String createRequest = "services/requests/";
  static const String uploadMedia   = "services/media/upload/";


//Home

  static const String customerHomepage    = "/services/requests/customer/homepage/";
  static const String allCustomerRequests = "/services/requests/customer/homepage/";
  static const String notifications       = "/services/notifications/";

}