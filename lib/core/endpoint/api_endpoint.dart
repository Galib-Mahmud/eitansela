// lib/core/endpoint/api_endpoint.dart

class ApiEndpoint {
  static const String baseUrl = 'https://handyapi.dsrt321.online/api';

  // ─── Auth ──────────────────────────────────────────────────────────
  static const String register       = "/auth/register/";
  static const String verifyOtp      = "/auth/verify-otp/";
  static const String login          = "/auth/login/";
  static const String forgotPassword = "/auth/forgot-password/";
  static const String verifyResetOtp = "/auth/verify-reset-otp/";
  static const String resetPassword  = "/auth/reset-password/";
  static const String profile        = "/auth/profile/";
  static const String logout         = "/auth/logout/";

  // ─── Service Requests ──────────────────────────────────────────────
  /// POST  body: { service, description, address, zip_code, phone_number, ... }
  static const String createRequest = "/services/requests/";

  /// POST  multipart: fields={request: id}, files={file: File}
  static const String uploadMedia   = "/services/media/upload/";

  /// POST  /services/requests/{id}/send-offer/
  static String sendOffer(int requestId) =>
      "/services/requests/$requestId/send-offer/";

  // ─── AI ────────────────────────────────────────────────────────────
  /// POST  body: { "request_id": N }
  static const String aiProcess = "/ai/process/";

  /// GET   /ai/result/{id}/   — poll until is_finished == true
  static const String aiResult  = "/ai/result/";

  // ─── Home ──────────────────────────────────────────────────────────
  static const String customerHomepage    = "/services/requests/customer/homepage/";
  static const String allCustomerRequests = "/services/requests/customer/homepage/";
  static const String notifications       = "/services/notifications/";

  // ─── Provider ──────────────────────────────────────────────────────
  static const String proHomepage        = "/services/requests/pro/homepage/";
  static const String providerProfile    = "/services/providers/";
  static const String proRequests        = "/services/requests/pro/requests/";
  static const String providerOnboarding = "/pro/onboarding/";
}