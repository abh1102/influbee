import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/login_Service.dart';
import '../app/routes.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      // Dummy login flow
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar("Login Success", "Welcome back!");
      Get.offAllNamed(AppRoutes.Main);
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
