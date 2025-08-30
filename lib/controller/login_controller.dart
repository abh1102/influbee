import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/login_Service.dart';
import '../app/routes.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final LoginService _loginService = LoginService();

  var isLoading = false.obs;

  var isPasswordHidden = true.obs;

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final response = await _loginService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Login Success", "Welcome back!",backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(AppRoutes.Main);
      } else {
        // ✅ Always show backend-provided message if available
        final message = response.data["message"] ?? "Unexpected error occurred";
        Get.snackbar("Login Failed", message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on DioException catch (dioError) {
      // ✅ Show exact message from API if present
      final message = dioError.response?.data["message"] ?? dioError.message;
      Get.snackbar("Error", message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
