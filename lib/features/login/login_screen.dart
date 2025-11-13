import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.lock, size: 80, color: Colors.blueAccent),
                  const SizedBox(height: 16),
                  const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),

                  // Email TextField
                  Obx(() => TextField(
                        controller: controller.emailController,
                        onChanged: controller.validateEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: controller.emailError.value.isEmpty
                              ? null
                              : controller.emailError.value,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      )),
                  const SizedBox(height: 16),

                  // Password TextField
                  Obx(() => TextField(
                        controller: controller.passwordController,
                        onChanged: controller.validatePassword,
                        obscureText: controller.isPasswordHidden.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value,
                          ),
                          errorText: controller.passwordError.value.isEmpty
                              ? null
                              : controller.passwordError.value,
                        ),
                      )),
                  const SizedBox(height: 24),

                  // Login Button
                  Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2)
                            : const Text('Login',
                                style: TextStyle(fontSize: 16)),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
