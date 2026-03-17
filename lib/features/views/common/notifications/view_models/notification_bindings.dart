

import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/auth/repository/auth_repository.dart';
import 'package:charteur/features/views/common/notifications/repository/notification_repository.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
          () => NotificationController(NotificationRepository()),
    );
  }
}