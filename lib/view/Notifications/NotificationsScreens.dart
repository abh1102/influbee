import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/NotificationsController.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      appBar: AppBar(
        title: Text("Notifications",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // white back button
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Text("No notifications",
                style: TextStyle(color: Colors.white54)),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar or Icon
                  notification.avatarUrl != null
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(notification.avatarUrl!),
                    radius: 22,
                  )
                      : CircleAvatar(
                    backgroundColor: Colors.orange.withOpacity(0.2),
                    child: Text(
                      notification.icon ?? "🔔",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  SizedBox(width: 12),

                  // Notification Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(notification.message,
                            style:
                            TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),

                  // Time ago
                  Text(notification.timeAgo,
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
