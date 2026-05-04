import 'package:eitansela/feature/auth/screen/sign_in_screen.dart';
import 'package:eitansela/feature/professional/auth/home1/main_screen_1.dart';
import 'package:eitansela/feature/professional/screen/homepage.dart';
import 'package:eitansela/feature/splash/screen/onboarding_screen1.dart';
import 'package:eitansela/feature/splash/screen/splash_screen.dart';
import 'package:eitansela/routes/route_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../feature/auth/screen/forget_password_screen.dart';
import '../feature/auth/screen/otp_verification_screen.dart';
import '../feature/auth/screen/password_reset_screen.dart';
import '../feature/auth/screen/password_reset_sucess_screen.dart';
import '../feature/auth/screen/sign_up_screen.dart';
import '../feature/customer/main_screen.dart';
import '../feature/customer/screen/analysis_loading_screen.dart';
import '../feature/customer/screen/chat_screen.dart';
import '../feature/customer/screen/close_screen.dart';
import '../feature/customer/screen/confirm_request_screen.dart';
import '../feature/customer/screen/home/views/home_screen.dart';
import '../feature/customer/screen/location_screen.dart';
import '../feature/customer/screen/my_request_screen.dart';
import '../feature/customer/screen/order_request/views/new_req1_screen.dart';
import '../feature/customer/screen/professional_screen.dart';
import '../feature/customer/screen/service_request.dart';
import '../feature/professional/screen/Onboardingpages/onboardingscreen.dart';
import '../feature/professional/screen/activejobscreen.dart';
import '../feature/professional/screen/eraningpage.dart';
import '../feature/professional/screen/home/views/professional_home_screen.dart';
import '../feature/professional/screen/job_request/views/job_requests_screen.dart';
import '../feature/professional/screen/jobrequestpage.dart';
import '../feature/professional/screen/profilepage.dart';
import '../feature/customer/profile/views/profile_screen.dart';
import '../feature/profile/screen/save_address.dart';
import '../feature/splash/screen/onboarding_screen2.dart';
import '../feature/splash/screen/onboarding_screen3.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.signin, page: () => SignInScreen()),
    GetPage(name: RouteName.splash, page: () => SplashScreen()),

    GetPage(name: RouteName.signup, page: () => SignUpScreen()),
    GetPage(name: RouteName.resetPassSucess, page: () => PasswordResetSuccessScreen(),),
    GetPage(name: RouteName.resetPass, page: () => PasswordResetScreen()),
    GetPage(name: RouteName.otpVerification, page: () => OtpVerificationScreen(),),
    GetPage(name: RouteName.forgetPass, page: () => ForgotPasswordScreen()),
    GetPage(name: RouteName.splashScreen, page: () => SplashScreen()),
    GetPage(name: RouteName.home, page: () => HomeDashboardScreen()),
    GetPage(name: RouteName.myRequest, page: () => MyRequest()),
    GetPage(name: RouteName.main, page: () => MainScreen()),
    GetPage(name: RouteName.profile, page: () => ProfileScreen()),
    GetPage(name: RouteName.savedAddresses, page: () => SavedAddressesScreen()),
    GetPage(name: RouteName.newRequest, page: () => NewRequestScreen()),
    GetPage(name: RouteName.newRequestAnalysis, page: () => NewRequestAnalysisScreen(),),
    GetPage(name: RouteName.newRequestScreen1, page: () => NewRequestScreen1()),
    GetPage(name: RouteName.professional, page: () => ProfessionalScreen()),
    GetPage(name: RouteName.chat, page: () => ProfessionalChatScreen()),
    GetPage(name: RouteName.location, page: () => ScheduleConfirmationScreen()),
    GetPage(name: RouteName.confirmReq, page: () => ConfirmRequestScreen()),
    GetPage(name: RouteName.review, page: () => ProfessionalChatScreen()),
    GetPage(name: RouteName.close, page: () => RequestClosedScreen()),

    //Professional
    GetPage(name: RouteName.main1, page: () => MainScreen1()),
    GetPage(name: RouteName.onboarding1, page: () => Onboarding()),
    GetPage(name: RouteName.professionalHome, page: () => ProfessionalHomeScreen()),
    GetPage(name: RouteName.jobRequests, page: () => JobRequestsScreen()),

    // Sohan
    GetPage(name: RouteName.homepage, page: () => Homepage()),
    GetPage(name: RouteName.jobrequest, page: () => JobRequestPage()),
    GetPage(name: RouteName.earning, page: () => EarningsPage()),
    GetPage(name: RouteName.profilepage, page: () => ProfilePage()),
    GetPage(name: RouteName.activejobscreen, page: () => ActiveJobScreen()),
    GetPage(name: RouteName.onboardingFlow, page: () => Onboarding()),
  ];
}
