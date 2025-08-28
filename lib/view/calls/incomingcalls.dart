import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/CallController.dart';

class IncomingCallScreen extends GetView<CallController> {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: SafeArea(
        child: Center(
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(controller.avatarUrl.value),
              ),
              const SizedBox(height: 20),

              // Caller Name
              Text(
                controller.callerName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),

              // Call Type
              Text(
                "Influbee ${controller.callType.value}",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 40),

              // Remind Me & Message
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.alarm,
                    label: "Remind me",
                    onTap: controller.onRemindMe,
                  ),
                  _ActionButton(
                    icon: Icons.message,
                    label: "Message",
                    onTap: controller.onMessage,
                  ),
                ],
              ),
              const SizedBox(height: 60),

              // Decline & Accept
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CallButton(
                    icon: Icons.call_end,
                    label: "Decline",
                    color: Colors.red,
                    onTap: controller.onDecline,
                  ),
                  _CallButton(
                    icon: Icons.call,
                    label: "Accept",
                    color: Colors.green,
                    onTap: controller.onAccept,
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.black54,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CallButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
