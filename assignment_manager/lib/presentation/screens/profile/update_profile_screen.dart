import 'dart:convert';

import 'package:assignment_manager/presentation/controllers/profile_controller.dart';
import 'package:assignment_manager/presentation/utils/app_colors.dart';
import 'package:assignment_manager/presentation/widgets/app_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _updateTextFields(ProfileController controller) {
    _fullNameController.text = controller.user?.name ?? '';
    _emailController.text = controller.user?.email ?? '';
    _mobileController.text = controller.user?.mobile ?? '';
  }

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
        child: GetBuilder<ProfileController>(builder: (controller) {
          if (controller.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _updateTextFields(controller);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.pickImageFromGallery();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(
                            base64Decode(controller.profilePhoto),
                          ),
                        ),
                      ),
                      const Gap(8),
                      Text('${controller.user?.name}'),
                      const Gap(32),
                      TextFormField(
                        controller: _fullNameController,
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(hintText: 'Full Name'),
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const Gap(8),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(hintText: 'Mobile'),
                      ),
                      const Gap(16),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: controller.inProgress==false,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.updateProfile(_fullNameController.text.toString(),_emailController.text.toString(),_mobileController.text.toString());
                            },
                            child: const Text('Update your Profile'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
