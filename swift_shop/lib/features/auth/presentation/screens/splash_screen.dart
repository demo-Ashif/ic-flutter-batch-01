import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/res/styles/colors.dart';
import 'package:swift_shop/core/router/app_router.dart';

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../../shared/widgets/swift_shop.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const path = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the token verification process from the AuthController
      _authController.tokenVerify();
    });

    // Listen to changes in the token verification state to navigate accordingly
    ever(_authController.isTokenValid, (isValid) {
      if (isValid == true) {
        // Token is valid, navigate to the dashboard
        Get.offAllNamed(AppRoutes.dashboardScreen);
      } else {
        // Check other conditions if token is not valid
        final isFirstTimer = sl<CacheHelper>().getFirstTimer();
        if (isFirstTimer == true) {
          Get.offAllNamed(AppRoutes.onboardingScreen);
        } else {
          Get.offAllNamed(AppRoutes.loginScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colours.lightThemePrimaryColour,
      body: Center(
        child: SwiftShop(),
      ),
    );
  }
}
