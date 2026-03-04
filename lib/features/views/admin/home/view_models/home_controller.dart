// features/auth/view_models/auth_controller.dart

import 'package:charteur/core/helpers/show_response_toast.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/features/views/admin/home/models/file_details_view_model.dart';
import 'package:charteur/features/views/admin/home/models/site_details_responsemodel.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/admin/home/models/workerlist_response_model.dart';
import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/common/profile/repository/profile_repository.dart';
import 'package:charteur/features/views/common/profile/view_models/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository);

  // ──  Controllers ────────────────────────────
  // ---- Office Info ---
  final companyNameCtrl  = TextEditingController();
  final locationCtrl     = TextEditingController();
  final phoneCtrl        = TextEditingController();
  final emailCtrl        = TextEditingController();
  final websiteCtrl      = TextEditingController();
  final descriptionCtrl  = TextEditingController();
  final selectedWorkType = TextEditingController();

  // -- Assign Task -----
  final workTitleController = TextEditingController();
  final siteTitleController = TextEditingController();
  final descriptionController = TextEditingController();
  final assignedToController = TextEditingController();
  final dueDateController = TextEditingController();

  // ── Observables ───────────────────────────────────────
  final isLoading    = false.obs;
  Map<int, bool> isAssignLoading = <int, bool>{}.obs;
  final role         = ''.obs;
  final siteListModel     = Rxn<SiteListResponseModel>();
  final fileDetailsModel  = Rxn<FileDetailsResponseModel>();
  final workerListModel  = Rxn<WorkerListResponseModel>();
  final taskDetailsModel  = Rxn<TaskDetailsResponseModel>();
  String? savedPath;
  DateTime date = DateTime(2025, 6, 29);

  // ── Lifecycle ─────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    role.value = Get.arguments?['role'] ?? '';
  }

  @override
  void onClose() {
    companyNameCtrl.dispose();
    locationCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    websiteCtrl.dispose();
    descriptionCtrl.dispose();
    //----assign task ----
    workTitleController.dispose();
    descriptionController.dispose();
    assignedToController.dispose();
    dueDateController.dispose();
    super.onClose();
  }

  // ── get site ─────────────────────────────────────────────
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
  // ── get details ─────────────────────────────────────────────
  Future<void> getSiteTaskDetails() async {
    String taskId = Get.arguments['taskId']??'';
    isLoading.value = true;

    try {
      final result = await _repository.getSiteDetails(taskId: taskId);

      switch (result) {
        case Success<TaskDetailsResponseModel>():
          taskDetailsModel.value = result.data;
        case Failure<TaskDetailsResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── get file details ─────────────────────────────────────────────
  Future<void> getFileDetails() async {
   String fileId = Get.arguments?['fileId'] ?? '' ;
    isLoading.value = true;

    try {
      final result = await _repository.getFileDetails(fileId: fileId);

      switch (result) {
        case Success<FileDetailsResponseModel>():
          fileDetailsModel.value = result.data;
          getFileData(fileDetailsModel.value??FileDetailsResponseModel());
        case Failure<FileDetailsResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  getFileData(FileDetailsResponseModel data){
    siteTitleController.text = data.data?.siteId?.siteTitle ?? '';

  }

  // ── get file details ─────────────────────────────────────────────
  Future<void> getWorkersOrAdmins({String role = 'all'}) async {

    isLoading.value = true;

    try {
      final result = await _repository.getWorkersOrAdmins(role: role);

      switch (result) {
        case Success<WorkerListResponseModel>():
          workerListModel.value = result.data;
        case Failure<WorkerListResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }



// ── Update Office Info ─────────────────────────────────
  Future<void> addCompanyInfo() async {
    isLoading.value = true;
    try {
      final result = await _repository.addCompanyInfo(
        name: companyNameCtrl.text.trim(),
        address: locationCtrl.text.trim(),
        workType: selectedWorkType.text.trim(),
        email: emailCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        website: websiteCtrl.text.trim(),
        description: descriptionCtrl.text.trim(),
      );

      switch (result) {
        case Success():
          Get.back();
          showSuccess('Profile updated successfully');
          Get.put(ProfileController(ProfileRepository())).getProfile();
        case Failure():
          showError((result as Failure).message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Update Work Status ─────────────────────────────────
  Future<void> updateWorkStatus({String status = 'Done'}) async {
    String taskId = Get.arguments['taskId']??'';
    isLoading.value = true;
    try {
      final result = await _repository.updateWorkStatus(status: status, taskId: taskId);

      switch (result) {
        case Success():
          Get.back();
          showSuccess('Profile updated successfully');
          getSiteTaskDetails();
        case Failure():
          showError((result as Failure).message);
      }
    } finally {
      isLoading.value = false;
    }
  }


  // ── Assign Task ─────────────────────────────────────────────
  Future<void> assignTask({String? fileName, String? fileId,String? assignedTo,int i=0}) async {
    isAssignLoading[i] = true;

    try {
      final result = await _repository.assignTask(
        filePath: savedPath,
        fileName: fileName,
        fileId: fileId,
        title: workTitleController.text,
        description: descriptionController.text,
        assignedTo: assignedTo,
        dueDate: date.toString(),
      );

      switch (result) {
        case Success<String>():
          showSuccess(result.data);
        case Failure<String>():
          showError(result.message);
      }
    } finally {
      isAssignLoading[i] = false;
    }
  }



}