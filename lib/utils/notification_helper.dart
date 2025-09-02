import 'package:flutter/material.dart';

class NotificationHelper {
  static void showTopNotification(
    BuildContext context, 
    String message, {
    IconData icon = Icons.check_circle,
    Color backgroundColor = const Color(0xFFFF9500),
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.6), // 60% transparency
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: backgroundColor.withOpacity(0.8),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
    overlay.insert(overlayEntry);
    
    // Remove after specified duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  // Specific notification types for different actions
  static void showSuccessNotification(BuildContext context, String message) {
    showTopNotification(
      context, 
      message,
      icon: Icons.check_circle,
      backgroundColor: const Color(0xFFFF9500),
    );
  }

  static void showDeleteNotification(BuildContext context, String message) {
    showTopNotification(
      context, 
      message,
      icon: Icons.delete,
      backgroundColor: const Color(0xFFFF6B6B),
    );
  }

  static void showInfoNotification(BuildContext context, String message) {
    showTopNotification(
      context, 
      message,
      icon: Icons.info,
      backgroundColor: const Color(0xFF4ECDC4),
    );
  }

  static void showWarningNotification(BuildContext context, String message) {
    showTopNotification(
      context, 
      message,
      icon: Icons.warning,
      backgroundColor: const Color(0xFFFFE66D),
    );
  }
}
