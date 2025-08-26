import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/NewPostController.dart';
import 'Preview.dart';
import 'Review.dart';
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
      child: SectionCard(
        color: card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('Review'),
            const SizedBox(height: 12),
            ReviewRow('Title', controller.title.value.isEmpty ? '—' : controller.title.value,textColor: Colors.white),
            ReviewRow('Description',
                controller.description.value.isEmpty ? '—' : controller.description.value, textColor: Colors.white,),
            ReviewRow('Price', controller.price.value.isEmpty ? '—' : '₹ ${controller.price.value}',textColor: Colors.white),
            const SizedBox(height: 12),
            const Divider(color: Colors.white12),
            const SizedBox(height: 8),
            const Text('Preview', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Obx(() {
              final f = controller.selectedFile.value;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: const Color(0xFF12162A),
                  child: f == null ? const Center(child: Text('No media')) : Preview(file: f),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
