import 'package:get/get.dart';
import 'package:influbee/app/routes.dart';
import 'package:influbee/view/Auth/signup/SignupScreen.dart';
import 'package:influbee/view/Auth/signup/signup_binding.dart';
import 'package:influbee/view/calls/voice_call_screen.dart';

import '../view/Auth/login_binding.dart';
import '../view/Auth/login_screen.dart';
import '../view/Home/Home_Screen.dart';
import '../view/Home/Home_binding.dart';
import '../view/Intro/Splash_Screen.dart';
import '../view/calls/voice_call_binding.dart';
import '../view/chat/Chat_binding.dart';
import '../view/chat/chatscreen.dart';


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

    ),

    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.CHAT,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.VOICE,
      page: () => VoiceCallsView(),
      binding:  VoiceBinding(),
    )

  ];
}
