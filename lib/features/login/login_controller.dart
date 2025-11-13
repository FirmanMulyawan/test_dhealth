import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/config/app_route.dart';

import '../../component/util/helper.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var emailError = RxString('');
  var passwordError = RxString('');
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  bool isEmailValid(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Email wajib diisi';
    } else if (!isEmailValid(value)) {
      emailError.value = 'Format email tidak valid';
    } else {
      emailError.value = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Password wajib diisi';
    } else if (value.length < 6) {
      passwordError.value = 'Minimal 6 karakter';
    } else {
      passwordError.value = '';
    }
  }

  void login() async {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if (emailError.isNotEmpty || passwordError.isNotEmpty) return;

    if (emailController.text == "firmanmulyawan@gmail.com" &&
        passwordController.text == "password") {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;

      AlertModel.showAlert(
        title: "Berhasil",
        message: "Anda Berhasil untuk login",
        buttonText: "Success",
        onClicked: () {
          Get.toNamed(AppRoute.dashboard, arguments: "Firman");
        },
      );
    } else {
      AlertModel.showAlert(
          title: "Gagal", message: "email dan password tidak benar");
    }
  }
}
