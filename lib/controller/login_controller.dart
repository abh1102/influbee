import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/login_Service.dart';
import '../app/routes.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _authService = AuthService();

  var isLoading = false.obs;

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final response = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Example: assuming success status is in response.data['success']
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Save token/session if needed
        // Navigate to home screen
        Get.offAllNamed(AppRoutes.HOME);
      } else {
        Get.snackbar('Login Failed', response.data['message'] ?? 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
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