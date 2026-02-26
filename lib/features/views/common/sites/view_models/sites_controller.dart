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
import 'package:charteur/features/views/common/sites/models/filelist_response_model.dart';
import 'package:charteur/features/views/common/sites/models/tasklist_response_model.dart';
import 'package:charteur/features/views/common/sites/repository/sites_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SitesController extends GetxController {
  final SitesRepository _repository;
  SitesController(this._repository);

  // ── Form Controllers ──────────────────────────────────
  final nameCtrl    = TextEditingController();
  final emailCtrl   = TextEditingController();


  // ── Observables ───────────────────────────────────────
  final isLoading    = false.obs;
  final role         = ''.obs;
  final siteListModel = Rxn<SiteListResponseModel>();
  final fileListModel = Rxn<FileListResponseModel>();
  final taskListModel = Rxn<TaskListResponseModel>();

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
  Future<void> getAssignedSite() async {
    isLoading.value = true;

    try {
      final result = await _repository.getAssignedSites();

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

  // ── Site Files ─────────────────────────────────────────────
  Future<void> getSiteFiles() async {
    final siteId = Get.arguments['siteId'] ?? '';
    isLoading.value = true;

    try {
      final result = await _repository.getSiteFiles(siteId: siteId);

      switch (result) {
        case Success<FileListResponseModel>():
          fileListModel.value = result.data;
        case Failure<FileListResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Site Task ─────────────────────────────────────────────
  Future<void> getSiteTask({String status = ''}) async {
    final siteId = Get.arguments['siteId'] ?? '';
    isLoading.value = true;

    try {
      final result = await _repository.getSiteTask(status: status);

      switch (result) {
        case Success<TaskListResponseModel>():
          taskListModel.value = result.data;
        case Failure<TaskListResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ──Upload Site file ─────────────────────────────────────────────
  Future<void> uploadSiteFile({String? fileName , String? filePath}) async {
    final siteId = Get.arguments['siteId'] ?? '';
    isLoading.value = true;

    try {
      final result = await _repository.uploadSiteFile();

      switch (result) {
        case Success<String>():
          showSuccess(result.data);
        case Failure<String>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

}