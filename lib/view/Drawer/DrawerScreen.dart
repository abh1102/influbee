// lib/widgets/custom_drawer.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0D102D),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- User Profile Card ---
          Card(
            color: Colors.white.withOpacity(0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.deepPurple,
                    child: Text('T', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  const SizedBox(height: 8),
                  const Text("Test User", style: TextStyle(color: Colors.white, fontSize: 16)),
                  const Text("test@test.com", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 8),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     color: Colors.orange.withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(6),
                  //   ),
                  //   // child: const Text("+ Voice Clone Creator",
                  //   //     style: TextStyle(color: Colors.orangeAccent, fontSize: 12)),
                  // ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- Navigate Section Card ---
          Card(
            color: Colors.white.withOpacity(0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("NAVIGATE", style: TextStyle(color: Colors.white54)),
                  ),
                  const SizedBox(height: 8),
                  _drawerItem(Icons.dashboard, "Dashboard", "Overview & analytics"),
                  _drawerItem(Icons.chat, "Chat", "Chat with fans"),
                  _drawerItem(Icons.call, "Voice Calls", "Manage voice calls"),
                  _drawerItem(Icons.account_balance_wallet, "Wallet & Earnings", "Track your income"),
                  _drawerItem(Icons.calendar_today, "Bookings", "Scheduled sessions"),
                  _drawerItem(Icons.video_library, "Content", "Posts & media"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- Account Section Card ---
          Card(
            color: Colors.white.withOpacity(0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("ACCOUNT", style: TextStyle(color: Colors.white54)),
                  ),
                  const SizedBox(height: 8),
                  _drawerItem(Icons.help_outline, "Help & Support", "FAQs, Support etc."),
                  _drawerItem(Icons.logout, "Logout", "Sign out from app"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _drawerItem(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      onTap: () {
        if (title == "Chat") {
          Get.toNamed(AppRoutes.CHAT);
        } else if (title == "Dashboard") {
          Get.offAllNamed(AppRoutes.HOME);
        }
        else if (title == "Voice Calls") {
          Get.toNamed(AppRoutes.VOICE);
        }
        else if (title == "Wallet & Earnings") {
          Get.toNamed(AppRoutes.WALLET);
        }
        else if (title == "Logout") {
          Get.offAllNamed(AppRoutes.LOGIN);

        }
      },
    );
  }
}
