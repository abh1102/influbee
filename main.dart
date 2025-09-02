// import 'package:flutter/material.dart';
// import 'pages/settings_page.dart';
// import 'pages/payout_setup_page.dart';
// import 'pages/pan_details_page.dart';
// import 'pages/bank_details_page.dart';
// import 'pages/enter_pin_page.dart';
// import 'pages/confirm_pin_page.dart';
// import 'pages/set_pin_page.dart';
// import 'pages/messages_page.dart';
// import 'pages/chat_conversation_page.dart';
// import 'pages/new_post_page.dart';
// import 'pages/wallet_page.dart';
// import 'pages/calls_page.dart';
// import 'pages/incoming_call_page.dart';
// import 'pages/active_call_page.dart';
// import 'pages/profile_dashboard_page.dart';
// import 'pages/profile_page.dart';
// import 'pages/notifications_page.dart';
// import 'pages/features_page.dart';
// import 'pages/password_page.dart';
// import 'pages/ai_bot_page.dart';
// import 'pages/login_page.dart';
// import 'pages/create_account_page.dart';
// import 'pages/forgot_password_page.dart';
// import 'pages/content_library_page.dart';
// import 'pages/new_post_media_page.dart';
// import 'pages/new_post_details_page.dart';
// import 'pages/new_post_price_page.dart';
// import 'pages/review_publish_page.dart';
// import 'pages/profile_picture_upload_page.dart';
// import 'pages/otp_verification_page.dart';
// import 'pages/reset_password_page.dart';
// import 'pages/billing_details_page.dart';
// import 'pages/setup_rates_page.dart';
// import 'pages/premium_calls_page.dart';
//
// void main() {
//   runApp(const PayoutApp());
// }
//
// class PayoutApp extends StatelessWidget {
//   const PayoutApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Payout App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.orange,
//         scaffoldBackgroundColor: const Color(0xFF1A1A1A),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF1A1A1A),
//           foregroundColor: Colors.white,
//         ),
//         // Fix text overflow globally
//         textTheme: const TextTheme().apply(
//           bodyColor: Colors.white,
//           displayColor: Colors.white,
//         ),
//         // Ensure proper text scaling
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       initialRoute: '/login',
//       routes: {
//         '/': (context) => const ProfileDashboardPage(),
//         '/all_pages': (context) => const HomePage(),
//         '/settings': (context) => const SettingsPage(),
//         '/payout_setup': (context) => const PayoutSetupPage(),
//         '/pan_details': (context) => const PanDetailsPage(),
//         '/bank_details': (context) => const BankDetailsPage(),
//         '/enter_pin': (context) => const EnterPinPage(),
//         '/confirm_pin': (context) => const ConfirmPinPage(),
//         '/set_pin': (context) => const SetPinPage(),
//         '/messages': (context) => const MessagesPage(),
//         '/chat_conversation': (context) => const ChatConversationPage(),
//         '/new_post': (context) => const NewPostPage(),
//         '/wallet': (context) => const WalletPage(),
//         '/calls': (context) => const CallsPage(),
//         '/incoming_call': (context) => const IncomingCallPage(),
//         '/active_call': (context) => const ActiveCallPage(),
//         '/dashboard': (context) => const ProfileDashboardPage(),
//         '/profile_dashboard': (context) => const ProfileDashboardPage(),
//         '/profile_settings': (context) => const ProfilePage(),
//         '/notifications': (context) => const NotificationsPage(),
//         '/features': (context) => const FeaturesPage(),
//         '/password': (context) => const PasswordPage(),
//         '/ai_bot': (context) => const AiBotPage(),
//         '/login': (context) => const LoginPage(),
//         '/create_account': (context) => const CreateAccountPage(),
//         '/forgot_password': (context) => const ForgotPasswordPage(),
//         '/content_library': (context) => const ContentLibraryPage(),
//         '/new_post_media': (context) => const NewPostMediaPage(),
//         '/new_post_details': (context) => const NewPostDetailsPage(),
//         '/new_post_price': (context) => const NewPostPricePage(),
//         '/review_publish': (context) => const ReviewPublishPage(),
//         '/profile_picture_upload': (context) => const ProfilePictureUploadPage(),
//         '/otp_verification': (context) => const OTPVerificationPage(),
//         '/reset_password': (context) => const ResetPasswordPage(),
//         '/billing_details': (context) => const BillingDetailsPage(),
//         '/setup_rates': (context) => const SetupRatesPage(),
//         '/premium_calls': (context) => const PremiumCallsPage(),
//       },
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       appBar: AppBar(
//         title: const Text(
//           'Payout App Demo',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF1A1A1A),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Icon(
//               Icons.account_balance_wallet,
//               color: Color(0xFFFF9500),
//               size: 80,
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Welcome to Payout App',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Navigate through the different pages to see the payout setup flow',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 48),
//
//             // Navigation Buttons
//             _buildNavigationButton(
//               context,
//               'Settings Page',
//               'View account settings, notifications, and more',
//               Icons.settings,
//               '/settings',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Payout Setup',
//               'Complete your payout setup in 3 steps',
//               Icons.payment,
//               '/payout_setup',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'PAN Details',
//               'Enter PAN details and upload PAN card',
//               Icons.credit_card,
//               '/pan_details',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Bank Details',
//               'Add your bank account information',
//               Icons.account_balance,
//               '/bank_details',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Enter PIN',
//               'Enter your 4-digit PIN to access account',
//               Icons.lock,
//               '/enter_pin',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Set Your PIN',
//               'Create a secure 4-digit PIN for your account',
//               Icons.shield,
//               '/set_pin',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Messages',
//               'View your chat conversations and messages',
//               Icons.message,
//               '/messages',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'New Post',
//               'Create and share new content with pricing',
//               Icons.add_box,
//               '/new_post',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Wallet',
//               'View balance, transactions and manage funds',
//               Icons.account_balance_wallet,
//               '/wallet',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Calls',
//               'Make calls, view history and earnings',
//               Icons.phone,
//               '/calls',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Profile Dashboard',
//               'View earnings, stats and analytics',
//               Icons.dashboard,
//               '/profile_dashboard',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Profile',
//               'Manage profile info and service pricing',
//               Icons.person_outline,
//               '/profile_settings',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Notifications',
//               'View messages and activity alerts',
//               Icons.notifications,
//               '/notifications',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Features',
//               'Toggle app features and preferences',
//               Icons.toggle_on,
//               '/features',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Password',
//               'Change your account password',
//               Icons.lock,
//               '/password',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'AI Bot',
//               'Configure your AI assistant',
//               Icons.smart_toy,
//               '/ai_bot',
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Authentication Pages',
//               style: TextStyle(
//                 color: Color(0xFFFF9500),
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Login',
//               'User login with email and password',
//               Icons.login,
//               '/login',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Create Account',
//               'Sign up with profile picture upload',
//               Icons.person_add,
//               '/create_account',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Forgot Password',
//               'Reset password with email verification',
//               Icons.lock_reset,
//               '/forgot_password',
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Content Creation Pages',
//               style: TextStyle(
//                 color: Color(0xFFFF9500),
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Content Library',
//               'Browse and manage your uploaded content',
//               Icons.library_books,
//               '/content_library',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'New Post - Media',
//               'Upload media with drag & drop functionality',
//               Icons.upload_file,
//               '/new_post_media',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'New Post - Details',
//               'Add title, description, tags, and categories',
//               Icons.edit_note,
//               '/new_post_details',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'New Post - Price',
//               'Set pricing and earnings breakdown',
//               Icons.attach_money,
//               '/new_post_price',
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Review & Publish',
//               'Final review and publishing options',
//               Icons.publish,
//               '/review_publish',
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Profile & Settings',
//               style: TextStyle(
//                 color: Color(0xFFFF9500),
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildNavigationButton(
//               context,
//               'Profile Picture Upload',
//               'Upload and manage profile picture',
//               Icons.camera_alt,
//               '/profile_picture_upload',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavigationButton(
//     BuildContext context,
//     String title,
//     String subtitle,
//     IconData icon,
//     String route,
//   ) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       child: ElevatedButton(
//         onPressed: () => Navigator.pushNamed(context, route),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2A2A2A),
//           padding: const EdgeInsets.all(16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: const BorderSide(color: Color(0xFFFF9500), width: 1),
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: const Color(0xFFFF9500),
//               size: 24,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//         child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//             Text(
//                     subtitle,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.arrow_forward_ios,
//               color: Color(0xFFFF9500),
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
