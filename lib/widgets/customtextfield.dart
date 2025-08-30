import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final RxBool? isHidden;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.isHidden,
  });

  @override
  Widget build(BuildContext context) {
    if (isPassword && isHidden != null) {
      // 👁 Password field with toggle
      return Obx(() {
        return TextFormField(
          controller: controller,
          obscureText: isHidden!.value,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden!.value ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: () => isHidden!.toggle(),
            ),
          ),
        );
      });
    }

    return TextFormField(
      controller: controller,
      obscureText: false,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
