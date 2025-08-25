import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:influbee/app/routes.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isAgreed = false.obs;
  var profileImage = Rx<File?>(null);

  // Error messages
  var nameError = "".obs;
  var emailError = "".obs;
  var passwordError = "".obs;
  var confirmPasswordError = "".obs;
  var termsError = "".obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    /// Clear name error when user types
    nameController.addListener(() {
      if (nameController.text.trim().isNotEmpty) {
        nameError.value = "";
      }
    });

    /// Clear email error when valid email entered
    emailController.addListener(() {
      final email = emailController.text.trim();
      if (GetUtils.isEmail(email)) {
        emailError.value = "";
      }
    });

    /// Clear password error if valid length
    passwordController.addListener(() {
      final password = passwordController.text.trim();
      if (password.length >= 6) {
        passwordError.value = "";
      }
    });

    /// Clear confirm password error when it matches
    confirmPasswordController.addListener(() {
      final confirmPassword = confirmPasswordController.text.trim();
      if (confirmPassword == passwordController.text.trim() &&
          confirmPassword.isNotEmpty) {
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

  void register() {
    // Reset errors
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
    if (isValid) {
      // Proceed with signup logic
      Get.snackbar("Signup Success",
          "Name: $name, Email: $email, Profile: ${profileImage.value?.path ?? 'No Image'}");
      Get.toNamed(AppRoutes.SETPIN);
    }
  }

}
