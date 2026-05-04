import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:eitansela/routes/app_route.dart';
import 'package:eitansela/routes/route_name.dart';
import 'core/color_theme.dart';
import 'core/local_storage/user_info.dart';

void main() async {
  // 1. Must be first to allow native communication (SharedPreferences/SystemChrome)
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Load SharedPreferences before the UI builds
  await UserInfo.init();

  // 3. Lock Orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 4. Gather state for routing
  final bool isLoggedIn = await UserInfo.isLoggedIn();
  final String? role = UserInfo.getRoleSync();
  final String? onboardingStatus = UserInfo.getOnboardingStatusSync();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    role: role,
    onboardingStatus: onboardingStatus,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? role;
  final String? onboardingStatus;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.role,
    this.onboardingStatus,
  });

  /// Logic to determine where the user starts
  String get _determineInitialRoute {
    if (!isLoggedIn) {
      return RouteName.splash;
    }

    if (role == 'CUSTOMER') {
      return RouteName.main;
    }

    if (role == 'PROVIDER') {
      return (onboardingStatus == 'APPROVED')
          ? RouteName.main1
          : RouteName.onboarding1;
    }

    // Safety fallback: if logged in but role is corrupted/missing
    return RouteName.signin;
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit should wrap GetMaterialApp
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      // REMOVED: useInheritedMediaQuery (usually unnecessary/causes build issues in newer Flutter)
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,

          // Use the logic-derived route
          initialRoute: _determineInitialRoute,
          getPages: AppRoute.pages,

          // Smoother transitions
          defaultTransition: Transition.cupertino,

          // This prevents GetX from being too aggressive with memory management
          // during the initial heavy build phase
          smartManagement: SmartManagement.keepFactory,
        );
      },
    );
  }
}