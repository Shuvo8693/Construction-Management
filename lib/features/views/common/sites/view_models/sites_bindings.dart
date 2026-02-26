

import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/admin/home/view_models/home_controller.dart';
import 'package:charteur/features/views/auth/repository/auth_repository.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';


class SitesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(HomeRepository()),
    );
  }
}