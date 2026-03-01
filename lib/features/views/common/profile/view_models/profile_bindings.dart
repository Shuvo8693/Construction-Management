
import 'package:charteur/features/views/common/profile/repository/profile_repository.dart';
import 'package:charteur/features/views/common/profile/view_models/profile_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';


class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
          () => ProfileController(ProfileRepository()),
    );
  }
}