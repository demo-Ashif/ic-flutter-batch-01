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

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     final userId = sl<CacheHelper>().getUserId();
    //     final accessToken = sl<CacheHelper>().getAccessToken();
    //     final isFirstTimer = sl<CacheHelper>().getFirstTimer();
    //
    //     if (userId != null && accessToken!.isNotEmpty) {
    //       Get.toNamed(AppRoutes.dashboardScreen);
    //     } else {
    //       if (isFirstTimer == true) {
    //         Get.toNamed(AppRoutes.onboardingScreen);
    //       } else {
    //         Get.toNamed(AppRoutes.loginScreen);
    //       }
    //     }
    //   },
    // );
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
