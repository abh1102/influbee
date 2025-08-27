import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;

  const ReviewRow(this.label, this.value, {this.textColor = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor, // <-- label color
              )),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: textColor,
              )),
        ],
      ),
    );
  }
}
