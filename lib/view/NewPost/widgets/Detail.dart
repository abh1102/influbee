import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/NewPostController.dart';
import 'Labelfield.dart';
import 'SectionCard.dart';
import 'SectionTitle.dart';

class DetailsStep extends StatelessWidget {
  const DetailsStep({super.key, required this.card, required this.controller});
  final Color card;
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    final titleCtrl = TextEditingController(text: controller.title.value);
    final descCtrl = TextEditingController(text: controller.description.value);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First card: Details
            SectionCard(
              color: card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Details'),
                  const SizedBox(height: 16),
                  LabeledField(
                    label: 'Title',
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: titleCtrl,
                      onChanged: (v) => controller.title.value = v,
                      decoration: _inputDecoration('Enter title'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LabeledField(
                    label: 'Description',
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: descCtrl,
                      onChanged: (v) => controller.description.value = v,
                      maxLines: 5,
                      decoration: _inputDecoration('Write something about your post'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Second card: Audience (Quick Action Selectable)
            SectionCard(
              color: card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Audience",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _quickSelectAction(
                          "Subscription",
                          Icons.subscriptions,
                          Colors.orange,
                          selected: controller.selectedAudience.value == 'Subscription',
                          onTap: () => controller.selectedAudience.value = 'Subscription'),
                      _quickSelectAction(
                          "Free",
                          Icons.card_giftcard,
                          Colors.deepPurple,
                          selected: controller.selectedAudience.value == 'Free',
                          onTap: () => controller.selectedAudience.value = 'Free'),
                      _quickSelectAction(
                          "Premium/Paid",
                          Icons.workspace_premium,
                          Colors.teal,
                          selected: controller.selectedAudience.value == 'Premium/Paid',
                          onTap: () => controller.selectedAudience.value = 'Premium/Paid'),
                    ],
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),

            SectionCard(
              color: card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Tags'),
                  const SizedBox(height: 16),
                  LabeledField(
                    label: 'Tags',
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: titleCtrl,
                      onChanged: (v) => controller.tag.value = v,
                      decoration: _inputDecoration('Add tags seperated by commas'),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFF0B0F1A),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFFFA21A), width: 1.2),
    ),
  );

  Widget _quickSelectAction(
      String title, IconData icon, Color color,
      {required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: selected ? Colors.black : color,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: selected ? Colors.yellow : Colors.transparent, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
