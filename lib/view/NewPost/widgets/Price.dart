import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controller/NewPostController.dart';
import 'Labelfield.dart';
import 'SectionCard.dart';
import 'SectionTitle.dart';

class PriceStep extends StatelessWidget {
  const PriceStep({super.key, required this.card, required this.controller});
  final Color card;
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    final priceCtrl = TextEditingController(text: controller.price.value);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SectionCard(
        color: card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('Price'),
            const SizedBox(height: 16),
            LabeledField(
              label: 'Amount',
              child: TextField(
                controller: priceCtrl,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                onChanged: (v) => controller.price.value = v,
                decoration: _inputDecoration('e.g. 499'),
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

}
