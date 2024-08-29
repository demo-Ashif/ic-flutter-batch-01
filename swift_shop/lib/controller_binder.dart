import 'package:get/get.dart';
import 'package:swift_shop/features/auth/presentation/controllers/auth_controller.dart';

import 'core/di/injection_container.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(sl()));
  }
}
