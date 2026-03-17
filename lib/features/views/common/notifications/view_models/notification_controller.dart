// features/auth/view_models/auth_controller.dart

import 'package:charteur/core/helpers/show_response_toast.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/features/views/admin/home/models/comment_response_model.dart';
import 'package:charteur/features/views/admin/home/models/file_details_view_model.dart';
import 'package:charteur/features/views/admin/home/models/remarks_response_model.dart';
import 'package:charteur/features/views/admin/home/models/site_details_responsemodel.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/admin/home/models/workerlist_response_model.dart';
import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/common/notifications/models/notification_response_model.dart';
import 'package:charteur/features/views/common/notifications/repository/notification_repository.dart';
import 'package:charteur/features/views/common/profile/repository/profile_repository.dart';
import 'package:charteur/features/views/common/profile/view_models/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository;
  NotificationController(this._repository);

  // ──  Controllers ────────────────────────────


  // ── Observables ───────────────────────────────────────
  final isLoading    = false.obs;
  Map<int, bool> isAssignLoading = <int, bool>{}.obs;
  final role         = ''.obs;
  final notificationResponse   = Rxn<NotificationResponse>();

  // ── Lifecycle ─────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    getNotifications();

  }


  // ── get site ─────────────────────────────────────────────
  Future<void> getNotifications() async {
    isLoading.value = true;

    try {
      final result = await _repository.getNotifications();

      switch (result) {
        case Success<NotificationResponse>():
          notificationResponse.value = result.data;
        case Failure<NotificationResponse>():
          showError(result.message);
      }
    } finally {
      isLoading.value = false;
    }
  }


}