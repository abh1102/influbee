import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Account
  var payoutEnabled = false.obs;

  // Notifications
  var pushNotifications = false.obs;
  var messageNotifications = false.obs;

  // App Settings
  var darkMode = false.obs;

  void togglePushNotifications(bool value) {
    pushNotifications.value = value;
  }

  void toggleMessageNotifications(bool value) {
    messageNotifications.value = value;
  }

  void toggleDarkMode(bool value) {
    darkMode.value = value;
  }
}
