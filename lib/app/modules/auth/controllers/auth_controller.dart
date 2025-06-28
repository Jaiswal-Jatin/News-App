import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/storage_service.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isLoginMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void checkLoginStatus() {
    isLoggedIn.value = StorageService.isLoggedIn;
    if (isLoggedIn.value) {
      userName.value = StorageService.userName;
      userEmail.value = StorageService.userEmail;
    }
  }

  void toggleAuthMode() {
    isLoginMode.value = !isLoginMode.value;
    clearForm();
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    if (emailController.text == 'admin@news.com' &&
        passwordController.text == '123456') {
      await StorageService.saveUserData(
        name: 'News User',
        email: emailController.text,
      );

      userName.value = 'News User';
      userEmail.value = emailController.text;
      isLoggedIn.value = true;

      Get.snackbar(
        'Success',
        'You have successfully logged in',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'Error',
        'Wrong email or password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    await StorageService.saveUserData(
      name: nameController.text,
      email: emailController.text,
    );

    userName.value = nameController.text;
    userEmail.value = emailController.text;
    isLoggedIn.value = true;

    Get.snackbar(
      'Success',
      'Your account has been created',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.offAllNamed('/home');

    isLoading.value = false;
  }

  Future<void> logout() async {
    await StorageService.logout();
    isLoggedIn.value = false;
    userName.value = '';
    userEmail.value = '';

    Get.snackbar(
      'Success',
      'You have successfully logged out',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );

    Get.offAllNamed('/auth');
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }
}
