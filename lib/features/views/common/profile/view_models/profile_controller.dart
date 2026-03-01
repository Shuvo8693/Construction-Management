

import 'package:charteur/core/config/app_constants.dart';
import 'package:charteur/core/helpers/prefs_helper.dart';
import 'package:charteur/core/helpers/show_response_toast.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/core/router/app_router.dart';
import 'package:charteur/core/widgets/jwt_decoder/payload_value.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/features/views/auth/repository/auth_repository.dart';
import 'package:charteur/features/views/common/profile/models/profile_response_model.dart';
import 'package:charteur/features/views/common/profile/repository/profile_repository.dart';
import 'package:charteur/features/views/common/sites/models/filelist_response_model.dart';
import 'package:charteur/features/views/common/sites/models/tasklist_response_model.dart';
import 'package:charteur/features/views/common/sites/repository/sites_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository;

  ProfileController(this._repository);

  // ── Form Controllers ──────────────────────────────────
  //--- Add Site ----
  final siteOwnerController = TextEditingController();


  // ── Observables ───────────────────────────────────────
  final isLoading = false.obs;
  final role = ''.obs;
  final profileModel = Rxn<ProfileResponseModel>();


  // ── Lifecycle ─────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    role.value = Get.arguments?['role'] ?? '';
  }

  @override
  void onClose() {
    siteOwnerController.dispose();
    super.onClose();
  }

  // ── Login ─────────────────────────────────────────────
  Future<void> getProfile() async {
    isLoading.value = true;

    try {
      final result = await _repository.getProfile();

      switch (result) {
        case Success<ProfileResponseModel>():
          profileModel.value = result.data;
        case Failure<ProfileResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

}
