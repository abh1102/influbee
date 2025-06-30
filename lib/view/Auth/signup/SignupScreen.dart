import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/SignUpController.dart';
import '../../../widgets/customtextfield.dart';


class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Icon(Icons.bubble_chart, size: 48, color: Colors.amber),
              const SizedBox(height: 8),
              const Text(
                'Influbee',
                style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Please Register Yourself',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Name *',
                      controller: controller.nameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Email *',
                      controller: controller.emailController,
                    ),
                    CustomTextField(
                      label: 'Phone',
                      controller: controller.phoneController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password *',
                      controller: controller.passwordController,
                      isPassword: true,
                    ),

                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF8A600), Color(0xFFFFC107)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: controller.register,
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
