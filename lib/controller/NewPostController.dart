import 'dart:io';
import 'package:get/get.dart';

class NewPostController extends GetxController {
  static const steps = ['Media', 'Details', 'Price', 'Review'];
  final currentStep = 0.obs;
  var selectedAudience = ''.obs;

  // Media
  final selectedFile = Rx<File?>(null);

  // Details
  final title = ''.obs;
  final description = ''.obs;
  final tag = ''.obs;

  // Price
  final price = ''.obs;

  // Actions
  void goTo(int index) {
    if (index >= 0 && index < steps.length) currentStep.value = index;
  }

  void nextStep() {
    if (currentStep.value < steps.length - 1) {
      currentStep.value++;
    } else {
      // Final submit could be handled here
    }
  }

  void previousOrCancel() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void setFile(File f) => selectedFile.value = f;

  double get progress => (currentStep.value + 1) / steps.length;
  bool get isLast => currentStep.value == steps.length - 1;
}
