import 'package:get/get.dart';

class CallController extends GetxController {
  var callerName = "Virat Kohli".obs;
  var callType = "Video Call".obs;
  var avatarUrl = "https://i.pravatar.cc/150?img=5".obs;

  // Actions
  void onDecline() {
    // Later: Agora leaveChannel()
    Get.back(); // Close screen
  }

  void onAccept() {
    // Later: Agora joinChannel()
    Get.snackbar("Call", "Accepting ${callerName.value}'s call...");
    // Navigate to ActiveCallScreen or start Agora session
  }

  void onRemindMe() {
    Get.snackbar("Reminder", "You will be reminded later.");
  }

  void onMessage() {
    Get.snackbar("Message", "Sending quick message...");
  }
}
