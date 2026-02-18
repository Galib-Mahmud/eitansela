import 'package:eitansela/feature/auth/screen/sign_in_screen.dart';
import 'package:eitansela/feature/professional/screen/homepage.dart';
import 'package:eitansela/feature/splash/screen/onboarding_screen1.dart';
import 'package:eitansela/feature/splash/screen/splash_screen.dart';
import 'package:eitansela/routes/route_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../feature/auth/screen/password_reset_screen.dart';
import '../feature/auth/screen/password_reset_sucess_screen.dart';
import '../feature/auth/screen/sign_up_screen.dart';
import '../feature/home/main_screen.dart';
import '../feature/home/screen/analysis_loading_screen.dart';
import '../feature/home/screen/chat_screen.dart';
import '../feature/home/screen/home_screen.dart';
import '../feature/home/screen/my_request_screen.dart';
import '../feature/home/screen/my_request_screen.dart';

import '../feature/home/screen/new_req1_screen.dart';
import '../feature/home/screen/new_request_screen.dart';
import '../feature/home/screen/professional_screen.dart';
import '../feature/professional/screen/jobrequestpage.dart';
import '../feature/profile/screen/profile_screen.dart';
import '../feature/profile/screen/save_address.dart';
import '../feature/splash/screen/onboarding_screen2.dart';
import '../feature/splash/screen/onboarding_screen3.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.signin, page: () => SignInScreen()),
    GetPage(name: RouteName.signup, page: () => SignUpScreen()),
    GetPage(
      name: RouteName.resetPassSucess,
      page: () => PasswordResetSuccessScreen(),
    ),
    GetPage(name: RouteName.resetPass, page: () => PasswordResetScreen()),
    GetPage(name: RouteName.splashScreen, page: () => SplashScreen()),
    GetPage(name: RouteName.onboarding1, page: () => Onboarding1Screen()),
    GetPage(name: RouteName.onboarding2, page: () => Onboarding2Screen()),
    GetPage(name: RouteName.onboarding3, page: () => Onboarding3Screen()),
    GetPage(name: RouteName.home, page: () => HomeDashboardScreen()),
    GetPage(name: RouteName.myRequest, page: () => MyRequest()),
    GetPage(name: RouteName.main, page: () => MainScreen()),
    GetPage(name: RouteName.profile, page: () => ProfileScreen()),
    GetPage(name: RouteName.savedAddresses, page: () => SavedAddressesScreen()),
    GetPage(name: RouteName.newRequest, page: () => NewRequestScreen()),
    GetPage(name: RouteName.newRequestAnalysis, page: () => NewRequestAnalysisScreen()),
    GetPage(name: RouteName.newRequestScreen1, page: () => NewRequestScreen1()),
    GetPage(name: RouteName.professional, page: () => ProfessionalScreen()),
    GetPage(name: RouteName.chat, page: () => ProfessionalChatScreen()),

    // Sohan
    GetPage(name: RouteName.homepage, page: () => Homepage()),
    GetPage(name: RouteName.jobrequest, page: () => JobRequestPage()),



  ];
}
