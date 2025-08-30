import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/SignUpController.dart';
import '../../../widgets/customtextfield.dart';
import '../../theme.dart';


class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body:Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: AppTheme.gradientColors,
    ),
    ),
      // backgroundColor: const Color(0xFF0D102D),
    child: Column(
    children: [
 AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture upload circle
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white24,
                    backgroundImage: controller.profileImage.value != null
                        ? FileImage(controller.profileImage.value!)
                        : null,
                    child: controller.profileImage.value == null
                        ? const Icon(Icons.person,
                        size: 50, color: Colors.white70)
                        : null,
                  )),
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: const Icon(Icons.image,
                          size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Upload a profile picture",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Full Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Full Name',
                    controller: controller.nameController,
                  ),
                  Obx(() => controller.nameError.value.isNotEmpty
                      ? Text(
                    controller.nameError.value,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 12),
                  )
                      : const SizedBox.shrink()),
                ],
              ),
              const SizedBox(height: 16),

              // Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Email',
                    controller: controller.emailController,
                  ),
                  Obx(() => controller.emailError.value.isNotEmpty
                      ? Text(
                    controller.emailError.value,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 12),
                  )
                      : const SizedBox.shrink()),
                ],
              ),
              const SizedBox(height: 16),

              // Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Password',
                    controller: controller.passwordController,
                    isPassword: true,
                    isHidden: controller.isPasswordHidden,
                  ),
                  Obx(() => controller.passwordError.value.isNotEmpty
                      ? Text(
                    controller.passwordError.value,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 12),
                  )
                      : const SizedBox.shrink()),
                ],
              ),
              const SizedBox(height: 16),

              // Confirm Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    isPassword: true,
                    isHidden: controller.isConfirmPasswordHidden,
                  ),
                  Obx(() => controller.confirmPasswordError.value.isNotEmpty
                      ? Text(
                    controller.confirmPasswordError.value,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 12),
                  )
                      : const SizedBox.shrink()),
                ],
              ),
              const SizedBox(height: 16),

              // Terms & Conditions Checkbox
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: controller.isAgreed.value,
                    onChanged: (value) {
                      controller.isAgreed.value = value ?? false;
                    },
                    activeColor: Colors.orange,
                  )),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style:
                        TextStyle(color: Colors.white70, fontSize: 13),
                        children: [
                          TextSpan(text: "I agree to the "),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(color: Colors.orange),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => controller.termsError.value.isNotEmpty
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.termsError.value,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 12),
                  ),
                ),
              )
                  : const SizedBox.shrink()),
              const SizedBox(height: 12),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: controller.register,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Already have an account
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    ]
    )
)
    );
  }
}
