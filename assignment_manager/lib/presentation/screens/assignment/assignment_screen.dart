import 'package:assignment_manager/presentation/screens/assignment/add_new_assignment_screen.dart';
import 'package:assignment_manager/presentation/widgets/task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/app_colors.dart';
import '../../widgets/app_background_widget.dart';
import '../../widgets/profile_app_bar.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackgroundWidget(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const TaskItem(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewAssignmentScreen(),
            ),
          );
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
