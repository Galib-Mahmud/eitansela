

import 'package:eitansela/feature/auth/screen/sign_in_screen.dart';
import 'package:eitansela/routes/route_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteName.signin,
      page: () => SignInScreen(),

    ),

  ];

}