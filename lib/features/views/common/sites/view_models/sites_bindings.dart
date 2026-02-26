
import 'package:charteur/features/views/common/sites/repository/sites_controller.dart';
import 'package:charteur/features/views/common/sites/repository/sites_repository.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';


class SitesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SitesController>(
          () => SitesController(SitesRepository()),
    );
  }
}