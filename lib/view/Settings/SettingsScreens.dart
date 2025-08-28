import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Settings_controllers.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Account Settings
            _sectionTitle("Account Settings"),
            _settingsCard([
              _settingsTile(Icons.account_balance_wallet, "Payout", () {}),
              _settingsTile(Icons.settings, "Feature Settings", () {}),
              _settingsTile(Icons.lock, "Password", () {}),
            ]),

            SizedBox(height: 20),

            // Notifications
            _sectionTitle("Notifications"),
            Obx(() => _settingsCard([
              _switchTile(Icons.notifications, "Push Notifications",
                  controller.pushNotifications.value,
                  controller.togglePushNotifications),
              _switchTile(Icons.message, "Message Notifications",
                  controller.messageNotifications.value,
                  controller.toggleMessageNotifications),
            ])),

            SizedBox(height: 20),

            // App Settings
            // _sectionTitle("App Settings"),
            // Obx(() => _settingsCard([
            //   _switchTile(Icons.dark_mode, "Dark Mode",
            //       controller.darkMode.value,
            //       controller.toggleDarkMode),
            // ])),

            SizedBox(height: 20),

            // Support & Legal
            _sectionTitle("Support & Legal"),
            _settingsCard([
              _settingsTile(Icons.help, "Help", () {}),
              _settingsTile(Icons.description, "Terms of Service", () {}),
              _settingsTile(Icons.privacy_tip, "Privacy Policy", () {}),
            ]),

            SizedBox(height: 30),

            // Logout Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.logout),
                label: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _switchTile(
      IconData icon, String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      activeColor: Colors.orange,
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: Colors.orange),
      title: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
