import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../Service/ForgetPassword.dart';


class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  var emailError = "".obs;
  var isLoading = false.obs;

  final ForgotPasswordService _service = ForgotPasswordService();

  Future<void> sendResetLink() async {
    emailError.value = "";
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = "Email is required";
      return;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = "Enter a valid email";
      return;
    }

    isLoading.value = true;
    try {
      final response = await _service.sendResetLink(email);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data["message"] ??
            "If an account with this email exists, you will receive an OTP shortly.";
        Get.snackbar(
          "Reset Link Sent",
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Message",
          response.data["message"] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioError catch (dioError) {
      Get.snackbar(
        "Message",
        dioError.response?.data["message"] ?? dioError.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
