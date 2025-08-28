import 'package:get/get.dart';
import '../Model/Notifications.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      NotificationModel(
        title: "New message from Pragya",
        message: "\"Hey! Loved your latest post. Let's collaborate?\"",
        timeAgo: "1h ago",
        avatarUrl:
        "https://randomuser.me/api/portraits/women/44.jpg", // demo avatar
      ),
      NotificationModel(
        title: "Your post is trending!",
        message: "Your recent video has entered the top 10 trending list.",
        timeAgo: "2h ago",
        icon: "🔥",
      ),
      NotificationModel(
        title: "New follower: AJ",
        message: "AJ started following you.",
        timeAgo: "3h ago",
        avatarUrl:
        "https://randomuser.me/api/portraits/men/32.jpg", // demo avatar
      ),
    ];
  }
}
