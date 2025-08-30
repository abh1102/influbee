import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New message from @Sophia_R',
      subtitle: 'That\'s love your latest post!\nLet\'s collaborate',
      time: '2 hours ago',
      avatar: 'SR',
      avatarColor: const Color(0xFF8B5CF6),
      isRead: false,
      type: NotificationType.message,
    ),
    NotificationItem(
      title: 'Your post is trending!',
      subtitle: 'Your recent video has entered\nthe top 50 trending list',
      time: '3 hours ago',
      avatar: '',
      avatarColor: const Color(0xFFFF9500),
      isRead: false,
      type: NotificationType.trending,
    ),
    NotificationItem(
      title: 'New follower! @Ethan_M',
      subtitle: '@Ethan_M started following\nyou.',
      time: '5 hours ago',
      avatar: 'EM',
      avatarColor: const Color(0xFF10B981),
      isRead: true,
      type: NotificationType.follow,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification.isRead = true;
                }
              });
            },
            child: const Text(
              'Mark all',
              style: TextStyle(
                color: Color(0xFFFF9500),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(notification, index);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            color: Colors.grey,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'When you get notifications, they\'ll show up here',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification, int index) {
    return Dismissible(
      key: Key('notification_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          notifications.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${notification.title} dismissed'),
            backgroundColor: const Color(0xFF2A2A2A),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            notification.isRead = true;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead 
                ? const Color(0xFF2A2A2A) 
                : const Color(0xFF2A2A2A).withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            border: notification.isRead 
                ? null 
                : Border.all(color: const Color(0xFFFF9500).withOpacity(0.3), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar or Icon
              _buildNotificationAvatar(notification),
              
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              color: notification.isRead ? Colors.grey : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          notification.time,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.subtitle,
                      style: TextStyle(
                        color: notification.isRead ? Colors.grey : Colors.grey[300],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Unread indicator
              if (!notification.isRead)
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 8),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF9500),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationAvatar(NotificationItem notification) {
    switch (notification.type) {
      case NotificationType.message:
      case NotificationType.follow:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.avatarColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              notification.avatar,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        );
      
      case NotificationType.trending:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.avatarColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.trending_up,
            color: notification.avatarColor,
            size: 20,
          ),
        );
      
      case NotificationType.system:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.avatarColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications,
            color: notification.avatarColor,
            size: 20,
          ),
        );
      
      default:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: notification.avatarColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.info,
            color: notification.avatarColor,
            size: 20,
          ),
        );
    }
  }
}

enum NotificationType {
  message,
  follow,
  trending,
  system,
  other,
}

class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final String avatar;
  final Color avatarColor;
  bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.avatar,
    required this.avatarColor,
    required this.isRead,
    required this.type,
  });
}
