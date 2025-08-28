class NotificationModel {
  final String title;
  final String message;
  final String timeAgo;
  final String? avatarUrl;
  final String? icon;

  NotificationModel({
    required this.title,
    required this.message,
    required this.timeAgo,
    this.avatarUrl,
    this.icon,
  });
}
