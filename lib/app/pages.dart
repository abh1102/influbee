import 'package:get/get.dart';
import 'package:influbee/app/routes.dart';
import 'package:influbee/view/Auth/ForgetPassword/Bindings.dart';
import 'package:influbee/view/Auth/signup/SignupScreen.dart';
import 'package:influbee/view/Auth/signup/signup_binding.dart';
import 'package:influbee/view/Notifications/NotificationsBinding.dart';
import 'package:influbee/view/Notifications/NotificationsScreens.dart';
import 'package:influbee/view/Settings/SettingsBindings.dart';
import 'package:influbee/view/Settings/SettingsScreens.dart';
import 'package:influbee/view/calls/voice_call_screen.dart';

import '../view/Auth/ForgetPassword/ForgetPassword.dart';
import '../view/Auth/Pin/SetThePin.dart';
import '../view/Auth/Pin/SetThePinBinding.dart';
import '../view/Auth/login_binding.dart';
import '../view/Auth/login_screen.dart';
import '../view/Home/Home_Screen.dart';
import '../view/Home/Home_binding.dart';
import '../view/Intro/Splash_Screen.dart';
import '../view/MainScreen/MainBinding.dart';
import '../view/MainScreen/MainScreen.dart';
import '../view/NewPost/NewPost.dart';
import '../view/WalletAndEarning/WalletBinding.dart';
import '../view/WalletAndEarning/WalletScreen.dart';
import '../view/Withdraw/WithdrawBindings.dart';
import '../view/Withdraw/withdrawScreen.dart';
import '../view/calls/Incomingcallsbinding.dart';
import '../view/calls/incomingcalls.dart';
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
       page: () => const HomeNewView(),
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
    ),
    GetPage(
      name: AppRoutes.WALLET,
      page: () => WalletScreen(),
      // binding: Walletbinding()
    ),
    // GetPage(
    //     name: AppRoutes.TRANSACTIONS,
    //     page: () => Withdrawscreen(),
    //     binding:  Transaction()
    // )
    GetPage(
      name: AppRoutes.Main,
      page: () => const MainScreen(),
        binding: MainBinding()
    ),
    GetPage(
      name: AppRoutes.FORGETPASSWORD,
      page: () => const ForgotPasswordView(),
      binding:ForgetBinding(),
    ),
    GetPage(
      name: AppRoutes.SETPIN,
      page: () =>  PinScreen(),
      binding:setpin(),
    ),
    GetPage(
      name: AppRoutes.NEWPOST,
      page: () =>  NewPostView(),
      binding:setpin(),
    ),
    GetPage(
      name: AppRoutes.NEWPOST,
      page: () =>  NewPostView(),
      binding:setpin(),
    ),
///ISKO EK BAAR CHECK KARNA HAI
    GetPage(
      name: AppRoutes.Calling,
      page: () =>  IncomingCallScreen(),
      binding:Incomingcalls(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () =>  SettingsScreen(),
      binding:Settingsbinding(),
    ),
    ///NOTIFICATIONS
    GetPage(
      name: AppRoutes.NOTIFICATIONS,
      page: () =>  NotificationScreen(),
      binding:NotificationsBindings(),
    ),
  ];
}
