import 'package:assignment_manager/presentation/utils/app_colors.dart';
import 'package:assignment_manager/presentation/widgets/app_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: AppBackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                  ),
                  const Gap(8),
                  const Text('Ashif Mujtoba'),
                  const Gap(32),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const Gap(8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  ),
                  const Gap(8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  ),
                  const Gap(8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                  ),
                  const Gap(16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Update your Profile'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
