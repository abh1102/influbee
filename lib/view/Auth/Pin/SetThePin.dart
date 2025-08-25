import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Pin_Controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme.dart';


class PinScreen extends StatelessWidget {
  final PinController controller = Get.put(PinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppTheme.gradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header
              Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(Icons.shield, color: Colors.yellow, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    "Set Your PIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Secure your account with a 4-digit PIN.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 40),

                  // PIN Indicator
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index < controller.pin.value.length
                                ? Colors.yellow
                                : Colors.white24,
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),

              // Keypad
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    buildNumberRow(["1", "2", "3"]),
                    buildNumberRow(["4", "5", "6"]),
                    buildNumberRow(["7", "8", "9"]),
                    buildNumberRow(["", "0", "⌫"]),
                  ],
                ),
              ),

              // Confirm Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: controller.confirmPin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Confirm PIN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberRow(List<String> numbers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: numbers.map((num) {
          if (num == "⌫") {
            return buildKey(
              icon: Icons.backspace,
              onTap: () => controller.removeDigit(),
            );
          } else if (num.isEmpty) {
            return const SizedBox(width: 60); // Empty space
          } else {
            return buildKey(
              text: num,
              onTap: () => controller.addDigit(num),
            );
          }
        }).toList(),
      ),
    );
  }

  Widget buildKey({String? text, IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Center(
          child: text != null
              ? Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          )
              : Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
