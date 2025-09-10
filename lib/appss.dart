import 'package:flutter/material.dart';
import 'package:influbee/pages/HomePage.dart';
import 'package:influbee/pages/active_call_page.dart';
import 'package:influbee/pages/ai_bot_page.dart';
import 'package:influbee/pages/bank_details_page.dart';
import 'package:influbee/pages/billing_details_page.dart';
import 'package:influbee/pages/calls_page.dart';
import 'package:influbee/pages/chat_conversation_page.dart';
import 'package:influbee/pages/confirm_pin_page.dart';
import 'package:influbee/pages/content_library_page.dart';
import 'package:influbee/pages/create_account_page.dart';
import 'package:influbee/pages/enter_pin_page.dart';
import 'package:influbee/pages/features_page.dart';
import 'package:influbee/pages/forgot_password_page.dart';
import 'package:influbee/pages/incoming_call_page.dart';
import 'package:influbee/pages/login_page.dart';
import 'package:influbee/pages/messages_page.dart';
import 'package:influbee/pages/new_post_details_page.dart';
import 'package:influbee/pages/new_post_media_page.dart';
import 'package:influbee/pages/new_post_page.dart';
import 'package:influbee/pages/new_post_price_page.dart';
import 'package:influbee/pages/notifications_page.dart';
import 'package:influbee/pages/otp_verification_page.dart';
import 'package:influbee/pages/pan_details_page.dart';
import 'package:influbee/pages/password_page.dart';
import 'package:influbee/pages/premium_calls_page.dart';
import 'package:influbee/pages/profile_dashboard_page.dart';
import 'package:influbee/pages/reset_password_page.dart';
import 'package:influbee/pages/review_publish_page.dart';
import 'package:influbee/pages/set_pin_page.dart';
import 'package:influbee/pages/setup_rates_page.dart';
import 'package:influbee/pages/wallet_page.dart';
import 'package:influbee/utils/app_theme.dart';

import 'Profile/profile_page.dart';
import 'Profile/profile_picture_upload_page.dart';
import 'main.dart';
import 'pages/settings_page.dart';
import 'pages/payout_setup_page.dart';
// import all other pages here...

class PayoutApp extends StatelessWidget {
  const PayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'influbee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          foregroundColor: Colors.white,
        ),
        // Fix text overflow globally
        textTheme: const TextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        // Ensure proper text scaling
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialRoute: '/login',
      initialRoute: '/all_page',
      routes: {
        '/': (context) => const ProfileDashboardPage(),
        '/all_pages': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
        '/payout_setup': (context) => const PayoutSetupPage(),
        '/pan_details': (context) => const PanDetailsPage(),
        '/bank_details': (context) => const BankDetailsPage(),
        '/enter_pin': (context) => const EnterPinPage(),
        '/confirm_pin': (context) => const ConfirmPinPage(),
        '/set_pin': (context) => const SetPinPage(),
        '/messages': (context) => const MessagesPage(),
        '/chat_conversation': (context) => const ChatConversationPage(),
        '/new_post': (context) => const NewPostPage(),
        '/wallet': (context) => const WalletPage(),
        '/calls': (context) => const CallsPage(),
        '/incoming_call': (context) => const IncomingCallPage(),
        '/active_call': (context) => const ActiveCallPage(),
        '/dashboard': (context) => const ProfileDashboardPage(),
        '/profile_dashboard': (context) => const ProfileDashboardPage(),
        '/profile_settings': (context) => const ProfilePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/features': (context) => const FeaturesPage(),
        '/password': (context) => const PasswordPage(),
        '/ai_bot': (context) => const AiBotPage(),
        '/login': (context) => const LoginPage(),
        '/create_account': (context) => const CreateAccountPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/content_library': (context) => const ContentLibraryPage(),
        '/new_post_media': (context) => const NewPostMediaPage(),
        '/new_post_details': (context) => const NewPostDetailsPage(),
        '/new_post_price': (context) => const NewPostPricePage(),
        '/review_publish': (context) => const ReviewPublishPage(),
        '/profile_picture_upload': (context) =>  ProfilePictureUploadPage(),
        '/otp_verification': (context) => const OTPVerificationPage(),
        '/reset_password': (context) => const ResetPasswordPage(),
        '/billing_details': (context) => const BillingDetailsPage(),
        '/setup_rates': (context) => const SetupRatesPage(),
        '/premium_calls': (context) => const PremiumCallsPage(),
      },
    );
  }
}
