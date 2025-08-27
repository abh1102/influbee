import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/NewPostController.dart';

Future<void> openScheduler(BuildContext context, NewPostController controller) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(days: 1)),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFFA21A),
            onPrimary: Colors.black,
            surface: Color(0xFF12162A),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFFA21A),
              onPrimary: Colors.black,
              surface: Color(0xFF12162A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final scheduledDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // 🔥 Store in controller
      controller.scheduledDateTime = scheduledDateTime;

      // Confirmation
      Get.snackbar(
        "Scheduled",
        "Post will be published on ${scheduledDateTime.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
    }
  }
}
