import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildHeader(),
              const SizedBox(height: 40),
              _buildAuthCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.newspaper, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 20),
        const Text(
          'NewsFlow',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Stay Connected with Indian News',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAuthCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Form(
          key: controller.formKey,
          child: Column(
            children: [
              _buildToggleButtons(),
              const SizedBox(height: 24),
              if (!controller.isLoginMode.value) _buildNameField(),
              _buildEmailField(),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildSubmitButton(),
              const SizedBox(height: 16),
              _buildDemoCredentials(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!controller.isLoginMode.value) controller.toggleAuthMode();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.isLoginMode.value
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: controller.isLoginMode.value
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (controller.isLoginMode.value) controller.toggleAuthMode();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !controller.isLoginMode.value
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !controller.isLoginMode.value
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      children: [
        TextFormField(
          controller: controller.nameController,
          validator: controller.validateName,
          decoration: InputDecoration(
            labelText: 'Name',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      children: [
        TextFormField(
          controller: controller.emailController,
          validator: controller.validateEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      validator: controller.validatePassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.isLoading.value
            ? null
            : () {
                if (controller.isLoginMode.value) {
                  controller.login();
                } else {
                  controller.register();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                controller.isLoginMode.value ? 'Login' : 'Sign Up',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildDemoCredentials() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: const Column(
        children: [
          Text(
            'Demo Login:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 4),
          Text('Email: admin@news.com', style: TextStyle(fontSize: 12)),
          Text('Password: 123456', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
