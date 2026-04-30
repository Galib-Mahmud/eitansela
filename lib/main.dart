import 'package:eitansela/routes/app_route.dart';
import 'package:eitansela/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/color_theme.dart';
import 'core/endpoint/api_client.dart';
import 'core/local_storage/user_info.dart';
import 'core/splash/controller/splash_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserInfo.init();
  runApp(const MyApp());
  Get.lazyPut(() => SplashController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: RouteName.jobrequest,
          getPages: AppRoute.pages,
        );
      },
    );
  }
}