import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.black, fontSize: 12)),
      const SizedBox(height: 6),
      child,
    ]);
  }
}
