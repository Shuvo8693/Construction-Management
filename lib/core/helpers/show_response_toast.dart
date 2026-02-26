// ── Helpers ───────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

void showError(String message) {
  Get.snackbar(
    'Error', message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

void showSuccess(String message) {
  Get.snackbar(
    'Success', message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}