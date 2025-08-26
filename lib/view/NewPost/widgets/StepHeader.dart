import 'package:flutter/material.dart';

import '../../../controller/NewPostController.dart';
class StepHeader extends StatelessWidget {
  const StepHeader({required this.controller});
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    const barHeight = 4.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Labels row (clickable)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(NewPostController.steps.length, (i) {
              final isActive = controller.currentStep.value == i;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.goTo(i),
                child: Text(
                  NewPostController.steps[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? Colors.white : Colors.white70,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          // Progress bar (full width grey + animated orange foreground)
          LayoutBuilder(
            builder: (context, cts) {
              final full = cts.maxWidth;
              final active = full * controller.progress;
              return Stack(
                children: [
                  Container(
                    height: barHeight,
                    width: full,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: barHeight,
                    width: active,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA21A),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
