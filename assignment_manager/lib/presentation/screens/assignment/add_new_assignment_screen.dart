import 'package:assignment_manager/presentation/widgets/app_background_widget.dart';
import 'package:assignment_manager/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddNewAssignmentScreen extends StatefulWidget {
  const AddNewAssignmentScreen({super.key});

  @override
  State<AddNewAssignmentScreen> createState() => _AddNewAssignmentScreenState();
}

class _AddNewAssignmentScreenState extends State<AddNewAssignmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  decoration: const InputDecoration(hintText: 'Enter title'),
                ),
                const Gap(16),
                TextFormField(
                  maxLines: 7,
                  decoration:
                      const InputDecoration(hintText: 'Enter description'),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Create New Assignment'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
