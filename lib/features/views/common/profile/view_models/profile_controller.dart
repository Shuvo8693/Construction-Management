import 'package:charteur/core/helpers/show_response_toast.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/features/views/common/profile/models/profile_response_model.dart';
import 'package:charteur/features/views/common/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository;
  ProfileController(this._repository);
// {
  //   "name": "John Doe",
  //   "phoneNumber": "+1234567890",
  //   "address": "123 Main Street, New York, USA",
  //   "experience": 5,
  //   "expertiseArea": "Civil Engineering",
  //   "employmentType": "Full-time"
  // }

  // ── Form Controllers ──────────────────────────────────
  // Profile Info
  final fullNameController       = TextEditingController();
  final phoneController          = TextEditingController();
  final emailController          = TextEditingController();
  final addressController        = TextEditingController();
  // Professional Info
  final employmentTypeController           = TextEditingController();
  final expertiseController      = TextEditingController();
  final experienceController     = TextEditingController();

  // ── Observables ───────────────────────────────────────
  final isLoading        = false.obs;
  final isUpdateLoading  = false.obs;
  final isCompanyAdded    = false.obs;
  final role             = ''.obs;
  final profileModel     = Rxn<ProfileResponseModel>();

  // ── Lifecycle ─────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    getProfile();
  }


  // ── Get Profile ───────────────────────────────────────
  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      final result = await _repository.getProfile();
      switch (result) {
        case Success<ProfileResponseModel>():
          profileModel.value = result.data;
          _populateFields(result.data);   // ✅ fill controllers
        case Failure<ProfileResponseModel>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Populate fields from API data ─────────────────────
  void _populateFields(ProfileResponseModel response) {
    final user = response.data;

    fullNameController.text   = user?.name ?? '';
    phoneController.text      = user?.phoneNumber ?? '';
    emailController.text      = user?.email ?? '';
    addressController.text    = user?.address ?? '';
    employmentTypeController.text   = user?.employmentType ?? '';
    expertiseController.text  = user?.expertiseArea ?? '';
    experienceController.text = user?.experience != null ? user!.experience.toString() : '0';

  }

  // ── Update Profile ────────────────────────────────────
  Future<void> updateProfile({String? filePath, String? fileName}) async {
    isUpdateLoading.value = true;
    try {
      final result = await _repository.updateProfile(
        filePath:       filePath,
        fileName:       fileName,
        fullName:       fullNameController.text,
        phone:          phoneController.text,
        email:          emailController.text,
        address:        addressController.text,
        employmentType :   employmentTypeController.text,
        expertise:      expertiseController.text,
        experience:     experienceController.text,
      );

      switch (result) {
        case Success<String>():
          showSuccess(result.data);
          getProfile(); // refresh
        case Failure<String>():
          showError(result.message);
      }
    } finally {
      isUpdateLoading.value = false;
    }
  }
}