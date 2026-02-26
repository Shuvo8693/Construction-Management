// features/auth/view_models/auth_controller.dart

import 'package:charteur/core/config/app_constants.dart';
import 'package:charteur/core/helpers/prefs_helper.dart';
import 'package:charteur/core/helpers/show_response_toast.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/features/views/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository);

  // ── Form Controllers ──────────────────────────────────
  final nameCtrl    = TextEditingController();
  final emailCtrl   = TextEditingController();


  // ── Observables ───────────────────────────────────────
  final isLoading    = false.obs;
  final role         = ''.obs;
  final siteListModel         = Rxn<SiteListResponseModel>();

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
    super.onClose();
  }

  // ── Login ─────────────────────────────────────────────
  Future<void> getSite() async {
    isLoading.value = true;

    try {
      final result = await _repository.getSites();

      switch (result) {
        case Success<SiteListResponseModel>():
          siteListModel.value = result.data;
        case Failure<SiteListResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

}