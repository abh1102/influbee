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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF482B1C),
              Color(0xFF4D3019),
              Color(0xFF371929),
              Color(0xFF422C15),
              Color(0xFF503418),
              Color(0xFF46281D),
              Color(0xFF3E2122),
              Color(0xFF402B15),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "influbee",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Welcome back to the hive",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 24),

                    // Email field
                    TextFormField(
                      controller: controller.emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration("Email address"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        if (!GetUtils.isEmail(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    // Password field with eye toggle
                    Obx(() {
                      return TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Password").copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              controller.isPasswordHidden.toggle();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      );
                    }),


                    const SizedBox(height: 12),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                         Get.toNamed(AppRoutes.FORGETPASSWORD);
                        },
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.loginUser();
                          }
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Google button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Google login
                        },
                        //
                        icon: IconButton(
                          icon: Image.asset('assets/Icons/google_icon.png', height: 28, width: 28),
                          onPressed: () {},
                        ), label: const Text(
                          " Continue With Google",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Signup link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.SIGNUP);
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.orangeAccent),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
