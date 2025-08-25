import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  var emailError = "".obs;

  void sendResetLink() {
    emailError.value = "";
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = "Email is required";
      return;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = "Enter a valid email";
      return;
    }

    // TODO: Add your API call for reset password
    Get.snackbar(
      "Reset Link Sent",
      "A password reset link has been sent to $email",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
