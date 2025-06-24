import 'package:get/get.dart';
import 'package:influbee/app/routes.dart';
import 'package:influbee/view/Auth/signup/SignupScreen.dart';
import 'package:influbee/view/Auth/signup/signup_binding.dart';

import '../view/Auth/login_binding.dart';
import '../view/Auth/login_screen.dart';
import '../view/Intro/Splash_Screen.dart';


class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.SIGNUP, page:()=> SignupView(),binding: SignUpBinding()

    )
  ];
}
