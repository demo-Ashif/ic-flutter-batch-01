import 'package:assignment_manager/presentation/controllers/completed_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/new_task_controller.dart';
import '../../widgets/app_background_widget.dart';
import '../../widgets/profile_app_bar.dart';
import '../../widgets/task_item.dart';

class CompletedScreen extends StatelessWidget {
  CompletedScreen({super.key});

  final CompletedTaskController _controller = Get.find<CompletedTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackgroundWidget(
        child: GetBuilder<CompletedTaskController>(builder: (controller) {
          return ListView.builder(
            itemCount: controller.completedTasks.length,
            itemBuilder: (context, index) {
              final task = controller.completedTasks[index];
              return TaskItemWidget(
                taskItem: task,
              );
            },
          );
        }),
      ),
    );
  }
}
