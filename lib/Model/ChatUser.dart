import 'package:flutter/material.dart';

class ChatUser {
  final String id;
  final String username;
  final String displayName;
  final String? avatar;
  final String role;
  final String initials;
  bool? isOnline;

  ChatUser({
    required this.id,
    required this.username,
    required this.displayName,
    this.isOnline,
    this.avatar,
    required this.role,
  }) : initials = (displayName.isNotEmpty ? displayName[0] : username[0]).toUpperCase();

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json["id"],
      username: json["username"] ?? "",
      displayName: json["displayName"] ?? "",
      avatar: json["avatar"],
      role: json["role"] ?? "",
    );
  }

  Color get avatarColor {
    final colors = [
      const Color(0xFF8B5CF6),
      const Color(0xFF06B6D4),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
    ];
    return colors[id.hashCode % colors.length];
  }

}
