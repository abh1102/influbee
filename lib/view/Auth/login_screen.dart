import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influbee/app/routes.dart';
import '../../controller/login_controller.dart';
import '../../widgets/customtextfield.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      body: Stack(
        children: [
          // You can later replace this with animated bees
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 0.2,
          //     child: Image.asset(
          //       'assets/images/bee_pattern.png',
          //       repeat: ImageRepeat.repeat,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Center(
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
                    'Welcome back to the hive!',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Form(
                      key: controller.formKey, // Link form key
                      child: Column(
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Email *',
                            controller: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter email';
                              if (!GetUtils.isEmail(value)) return 'Enter valid email';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Password *',
                            controller: controller.passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please enter password';
                              if (value.length < 6) return 'Password must be at least 6 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: Container(
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
                                ),
                                onPressed: () {
                                  if (controller.formKey.currentState!.validate()) {
                                    // All validations passed
                                    // controller.loginUser();
                                    Get.toNamed(AppRoutes.HOME);
                                  }
                                },
                                child: const Center(child: Text('Sign In')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                  const SizedBox(height: 20),
                  // TextButton(
                  //   onPressed: () {
                  //     Get.toNamed(AppRoutes.SIGNUP);
                  //   },
                  //   // child: const Text(
                  //   //   "Don't have an account? Sign Up",
                  //   //   style: TextStyle(color: Colors.white70),
                  //   // ),
                  // ),
                  const SizedBox(height: 10),
                  // OutlinedButton(
                  //   onPressed: () {},
                  //   style: OutlinedButton.styleFrom(
                  //     side: const BorderSide(color: Colors.orangeAccent),
                  //   ),
                  //   // child: const Text(
                  //   //   'Clear Session (Dev)',
                  //   //   style: TextStyle(color: Colors.orangeAccent),
                  //   // ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
