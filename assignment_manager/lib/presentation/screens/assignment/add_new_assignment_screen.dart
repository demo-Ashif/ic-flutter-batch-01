import 'dart:developer';

import 'package:assignment_manager/presentation/controllers/new_task_controller.dart';
import 'package:assignment_manager/presentation/widgets/app_background_widget.dart';
import 'package:assignment_manager/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/toast_util.dart';

class AddNewAssignmentScreen extends StatefulWidget {
  const AddNewAssignmentScreen({super.key});

  @override
  State<AddNewAssignmentScreen> createState() => _AddNewAssignmentScreenState();
}

class _AddNewAssignmentScreenState extends State<AddNewAssignmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _addNewTask() async {
    final result = await _newTaskController.addNewTask(
      _titleController.text.trim(),
      _descController.text.trim(),
    );

    //show message
    if (mounted && result == true) {
      ToastUtil.showSnackBarMessage(
          context, 'New Task Created');
      Navigator.pop(context);
    } else {
      //show error message
      if (mounted) {
        log(_newTaskController.errorMessage);
        ToastUtil.showSnackBarMessage(
          context,
          _newTaskController.errorMessage,
          isErrorMessage: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackgroundWidget(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(45),
                Text(
                  'Create New Assignment',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 23,
                      ),
                ),
                const Gap(16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Enter title'),
                ),
                const Gap(16),
                TextFormField(
                  controller: _descController,
                  maxLines: 7,
                  decoration:
                      const InputDecoration(hintText: 'Enter description'),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<NewTaskController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addNewTask();
                          }
                        },
                        child: const Text('Create New Assignment'),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
