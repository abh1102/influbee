import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:influbee/app/routes.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/SignUpService.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var isAgreed = false.obs;
  var profileImage = Rx<File?>(null);

  // Error messages
  var nameError = "".obs;
  var emailError = "".obs;
  var passwordError = "".obs;
  var confirmPasswordError = "".obs;
  var termsError = "".obs;

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  final SignupService _signupService = SignupService();

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      if (nameController.text.trim().isNotEmpty) {
        nameError.value = "";
      }
    });

    emailController.addListener(() {
      final email = emailController.text.trim();
      if (GetUtils.isEmail(email)) {
        emailError.value = "";
      }
    });

    passwordController.addListener(() {
      if (passwordController.text.trim().length >= 6) {
        passwordError.value = "";
      }
    });

    confirmPasswordController.addListener(() {
      if (confirmPasswordController.text.trim() ==
          passwordController.text.trim() &&
          confirmPasswordController.text.trim().isNotEmpty) {
        confirmPasswordError.value = "";
      }
    });
  }
  Future<void> pickImage() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.orange),
              title: const Text("Take a Photo"),
              onTap: () async {
                final pickedFile =
                await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  profileImage.value = File(pickedFile.path);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.orange),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                final pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  profileImage.value = File(pickedFile.path);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    nameError.value = "";
    emailError.value = "";
    passwordError.value = "";
    confirmPasswordError.value = "";
    termsError.value = "";

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    bool isValid = true;

    if (name.isEmpty) {
      nameError.value = "Name is required";
      isValid = false;
    }
    if (email.isEmpty) {
      emailError.value = "Email is required";
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = "Enter a valid email";
      isValid = false;
    }
    if (password.isEmpty) {
      passwordError.value = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
      isValid = false;
    }
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Confirm your password";
      isValid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = "Passwords do not match";
      isValid = false;
    }
    if (!isAgreed.value) {
      termsError.value = "You must agree to continue";
      isValid = false;
    }
    if (profileImage.value == null) {
      Get.snackbar("Error", "Profile picture is required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      isValid = false;
    }

    if (!isValid) return;

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      final response = await _signupService.signup(
        email: email,
        username: name,
        password: password,
        confirmPassword: confirmPassword,
        phoneNumber: "1234567890", // dummy value (can be dynamic later)
        profileImage: profileImage.value!,
      );

      Get.back(); // close loader

      Get.snackbar("Success", "Signup successful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      Get.toNamed(AppRoutes.SETPIN);
    } catch (e) {
      Get.back(); // close loader
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }
}
