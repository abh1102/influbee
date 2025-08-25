import 'package:get/get.dart';
import 'package:influbee/app/routes.dart';

import '../utils/SnackBar.dart';

class PinController extends GetxController {
  var pin = "".obs;

  void addDigit(String digit) {
    if (pin.value.length < 4) {
      pin.value += digit;
    }
  }

  void removeDigit() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  bool get isComplete => pin.value.length == 4;


  void confirmPin() {
    if (isComplete) {
      AppSnackbar.success("Your PIN is ${pin.value}", title: "PIN Set");
      Get.toNamed(AppRoutes.Main);
    } else {
      AppSnackbar.error("Please enter a 4-digit PIN");
    }
  }
}
