

import 'package:charteur/features/views/admin/home/repository/home_repository.dart';
import 'package:charteur/features/views/auth/repository/auth_repository.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(HomeRepository()),
    );
  }
}