import 'dart:ui';

class ChatItem {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool isOnline;
  final int unreadCount;
  final Color avatarColor;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.isOnline,
    required this.unreadCount,
    required this.avatarColor,
  });
}