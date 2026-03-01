// features/auth/view_models/auth_controller.dart

import 'package:charteur/core/config/app_constants.dart';
import 'package:charteur/core/helpers/prefs_helper.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/features/views/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  final AuthRepository _repository;
  AuthController(this._repository);

  // ── Form Controllers ──────────────────────────────────
  final nameCtrl    = TextEditingController();
  final emailCtrl   = TextEditingController();
  final phoneNumberCtrl   = TextEditingController();
  final passCtrl    = TextEditingController();
  final otpCtrl     = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final oldPassCtrl = TextEditingController();

  // ── Observables ───────────────────────────────────────
  final isLoading    = false.obs;
  final role         = ''.obs;
  final user         = Rxn<UserModel>();

  // ── Lifecycle ─────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    role.value = Get.arguments?['role'] ?? '';
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    otpCtrl.dispose();
    newPassCtrl.dispose();
    oldPassCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }

  // ── Login ─────────────────────────────────────────────
  Future<void> login() async {
    isLoading.value = true;

    try {
      final result = await _repository.login(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      switch (result) {
        case Success<String>():
          // Save token then update NetworkCaller
          print(result.data);
          await PrefsHelper.setString('token', result.data);
          Get.offAllNamed(AppRoutes.adminHome);
        case Failure<String>():
          _showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Register ──────────────────────────────────────────
  Future<void> register() async {
    isLoading.value = true;

    try {
      final result = await _repository.register(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
        role: role.value,
        phoneNumber: phoneNumberCtrl.text.trim(),
      );
      
      switch (result) {
        case Success<String>():
          Get.toNamed(AppRoutes.otp, arguments: {'email': emailCtrl.text.trim()});
        case Failure<String>():
          _showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Verify OTP ────────────────────────────────────────
  Future<void> verifyOtp() async {
    isLoading.value = true;

    final result = await _repository.verifyOtp(
      email: Get.arguments?['email'] ?? emailCtrl.text.trim(),
      otp: otpCtrl.text.trim(),
    );

    switch (result) {
      case Success():
       if(result.data.isNotEmpty){
         await PrefsHelper.setString('token', result.data);
         Get.offAllNamed(AppRoutes.adminHome);
       }
      case Failure():
        _showError((result as Failure).message);
    }

    isLoading.value = false;
  }

  // ── Resend OTP ────────────────────────────────────────
  Future<void> resendOtp() async {
    isLoading.value = true;

    final result = await _repository.sendOtp(
      Get.arguments?['email'] ?? emailCtrl.text.trim(),

    );
    switch (result) {
      case Success():
        _showSuccess('OTP resent successfully');
      case Failure():
        _showError((result as Failure).message);
    }

    isLoading.value = false;
  }

  // ── Forgot Password ───────────────────────────────────
  Future<void> forgotPassword() async {
    isLoading.value = true;

    final result = await _repository.forgotPassword(emailCtrl.text.trim());

    switch (result) {
      case Success():
        Get.toNamed(AppRoutes.otp, arguments: {'email': emailCtrl.text.trim()});
      case Failure():
        _showError((result as Failure).message);
    }

    isLoading.value = false;
  }

  // ── Reset Password ────────────────────────────────────
  Future<void> resetPassword() async {
    isLoading.value = true;

    final result = await _repository.resetPassword(
      token: Get.arguments?['token'] ?? '',
      newPassword: newPassCtrl.text.trim(),
    );

    switch (result) {
      case Success():
        Get.offAllNamed(AppRoutes.login);
        _showSuccess('Password reset successfully');
      case Failure():
        _showError((result as Failure).message);
    }

    isLoading.value = false;
  }

  // ── Change Password ───────────────────────────────────
  Future<void> changePassword() async {
    isLoading.value = true;

    final result = await _repository.changePassword(
      oldPassword: oldPassCtrl.text.trim(),
      newPassword: newPassCtrl.text.trim(),
    );

    switch (result) {
      case Success():
        Get.back();
        _showSuccess('Password changed successfully');
      case Failure():
        _showError((result as Failure).message);
    }

    isLoading.value = false;
  }

  // ── Logout ────────────────────────────────────────────
  Future<void> logout() async {
    // await _repository.logout();
    await PrefsHelper.remove('token');
    NetworkCaller.instance.clearToken();          // ← your NetworkCaller method
    Get.offAllNamed(AppRoutes.login);
  }

  // ── Helpers ───────────────────────────────────────────
  void _showError(String message) {
    Get.snackbar(
      'Error', message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success', message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}