import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/NewPostController.dart';
import 'Preview.dart';
import 'Review.dart';
import 'Scheduler.dart';
import 'SectionCard.dart';
import 'SectionTitle.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key, required this.card, required this.controller});
  final Color card;
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Content Preview ---
          const Text(
            'Content Preview',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          Obx(() {
            final f = controller.selectedFile.value;
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 180,
                width: double.infinity,
                color: const Color(0xFF12162A),
                child: f == null
                    ? const Center(
                    child: Text('No media', style: TextStyle(color: Colors.white54)))
                    : Preview(file: f),
              ),
            );
          }),

          const SizedBox(height: 16),

          // --- Summary Section ---
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Summary',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white)),
                const SizedBox(height: 12),
                Text(
                  'Caption:',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.description.value.isEmpty
                      ? '—'
                      : controller.description.value,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tags:',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: controller.tags.isEmpty
                      ? [const Text('—', style: TextStyle(color: Colors.white))]
                      : controller.tags
                      .map((t) => Chip(
                    label: Text(t,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                    backgroundColor: Colors.white12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Price:',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                    Text(
                      controller.price.value.isEmpty
                          ? '—'
                          : '₹ ${controller.price.value}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Usage Rights:',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                    Text(
                      '1 Year exclusive',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- Publishing Checklist ---
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Publishing Checklist',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white)),
                const SizedBox(height: 16),

                // Buttons row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFA21A),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Publish Now'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Inside your Schedule button:
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => openScheduler(context, controller),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Schedule'),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Save as Draft',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
