import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  var selectedDate = Rxn<DateTime>();
  var selectedSlot = RxnString();

  // Predefined available slots
  final List<String> availableSlots = [
    "09:00 AM",
    "11:00 AM",
    "01:00 PM",
    "03:00 PM",
    "05:00 PM",
  ];

  void pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)), // 2 months limit
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Color(0xFF0D102D),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      pickSlot(context);
    }
  }

  void pickSlot(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E2C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Time Slot",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: availableSlots.map((slot) {
                return Obx(() {
                  bool isSelected = selectedSlot.value == slot;
                  return ChoiceChip(
                    label: Text(slot),
                    selected: isSelected,
                    onSelected: (val) {
                      selectedSlot.value = slot;
                    },
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                    backgroundColor: const Color(0xFF2C2C3A),
                  );
                });
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (selectedSlot.value != null) {
                  confirmBooking();
                  Get.back();
                } else {
                  Get.snackbar(
                    'Select Slot',
                    'Please select a time slot.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
  void confirmBooking() {
    Get.snackbar(
      'Booking Confirmed',
      'Date: ${selectedDate.value!.day}/${selectedDate.value!.month} at ${selectedSlot.value}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }
}
