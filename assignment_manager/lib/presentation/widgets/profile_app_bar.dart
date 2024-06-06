import 'package:assignment_manager/app.dart';
import 'package:assignment_manager/presentation/screens/profile/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
          AssignmentManagerApp.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: const Row(
        children: [
          CircleAvatar(radius: 20),
          Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ashif Mujtoba',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                'ashif.mujtoba@gmail.com',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
