import 'package:assignment_manager/controller_binder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/screens/auth/splash_screen.dart';
import 'presentation/utils/app_colors.dart';

class AssignmentManagerApp extends StatefulWidget {
  const AssignmentManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<AssignmentManagerApp> createState() => _AssignmentManagerAppState();
}

class _AssignmentManagerAppState extends State<AssignmentManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: AssignmentManagerApp.navigatorKey,
      title: 'Assignment Manager',
      home: const SplashScreen(),
      theme: _themeData,
      initialBinding: ControllerBinder(),
    );
  }

  final _themeData = ThemeData(
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0x75D5D5D5),
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: AppColors.themeColor,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16))),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),

      chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          )
      )
  );
}
