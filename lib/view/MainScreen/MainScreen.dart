import 'package:flutter/material.dart';

// Import your pages
import '../../controller/Home_Controller.dart';
import '../../controller/VoiceController.dart';
import '../ExclusiveContent/Content.dart';
import '../Home/Home_Screen.dart';
import '../WalletAndEarning/WalletScreen.dart';
import '../calls/voice_call_screen.dart';
import '../chat/chatscreen.dart';
// Add your ChatView, CallsView, WalletView, ExclusiveView
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Home/Home_Screen.dart';
import '../WalletAndEarning/WalletScreen.dart';
import '../calls/voice_call_screen.dart';
import '../chat/chatscreen.dart';
import 'MainController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your views here
// import 'home_new_view.dart';
// import 'chat_screen.dart';
// import 'voice_calls_view.dart';
// import 'wallet_screen.dart';
// import 'placeholder_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());
    final HomeNewController homeController = Get.put(HomeNewController()); // <-- add this
    final VoiceCallsController voiceController = Get.put(VoiceCallsController());
    final List<Widget> screens = [
      const HomeNewView(),
      ChatScreen(),
      VoiceCallsView(),
      WalletScreen(),
      ContentScreen(),
    ];

    return Obx(() => Scaffold(
      body: screens[controller.selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D102D),
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Exclusive",
          ),        ],
      ),
    ));
  }
}



// Temporary placeholder screen for other tabs
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
