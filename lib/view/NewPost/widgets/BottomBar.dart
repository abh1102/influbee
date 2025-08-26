import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controller/NewPostController.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required this.controller});
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    final isFirst = controller.currentStep.value == 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => controller.previousOrCancel(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white24),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                backgroundColor: const Color(0xFF0B0F1A),
              ),
              child: Text(isFirst ? 'Cancel' : 'Back',
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => controller.nextStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA21A),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(controller.isLast ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
