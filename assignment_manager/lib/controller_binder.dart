import 'package:assignment_manager/presentation/controllers/new_task_controller.dart';
import 'package:assignment_manager/presentation/controllers/profile_controller.dart';
import 'package:assignment_manager/presentation/controllers/sign_in_controller.dart';
import 'package:assignment_manager/presentation/controllers/sign_up_controller.dart';
import 'package:get/get.dart';

import 'presentation/controllers/completed_task_controller.dart';
import 'presentation/controllers/overview_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => OverviewTaskController());
  }
}
