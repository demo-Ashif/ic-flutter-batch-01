import 'package:assignment_manager/presentation/controllers/overview_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/completed_task_controller.dart';
import '../../widgets/app_background_widget.dart';
import '../../widgets/profile_app_bar.dart';
import '../../widgets/task_counter_card.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  final OverviewTaskController _controller = Get.find<OverviewTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackgroundWidget(
        child: GetBuilder<OverviewTaskController>(builder: (controller) {
          return GridView.builder(
            itemCount: controller.taskOverviewList.length,
            itemBuilder: (context, index) {
              final overview = controller.taskOverviewList[index];
              return TaskCounterCard(
                status: overview.status,
                count: overview.total,
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,),

          );
        }),
      ),
    );
  }
}
