import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/router/app_router.dart';
import 'package:swift_shop/core/router/getx_router.dart';
import 'package:swift_shop/features/auth/presentation/screens/login_screen.dart';
import 'package:swift_shop/features/auth/presentation/screens/splash_screen.dart';
import 'package:swift_shop/features/home/presentation/screens/home_screen.dart';

import 'controller_binder.dart';
import 'core/di/injection_container.dart';
import 'core/res/styles/colors.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/onboarding/views/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const ProviderScope(child: SwiftShopApp()));
}

class SwiftShopApp extends StatelessWidget {
  const SwiftShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colours.lightThemePrimaryColour,
      ),
      fontFamily: 'Switzer',
      scaffoldBackgroundColor: Colours.lightThemeTintStockColour,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colours.lightThemeTintStockColour,
          foregroundColor: Colours.lightThemePrimaryTextColour),
      useMaterial3: true,
    );

    return GetMaterialApp(
      title: 'Swift Shop',
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      // home: const OnBoardingScreen(),
      initialBinding: ControllerBinder(),
      darkTheme: theme.copyWith(
        scaffoldBackgroundColor: Colours.darkThemeBGDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colours.darkThemeBGDark,
          foregroundColor: Colours.lightThemeWhiteColour,
        ),
      ),
      getPages: GetAppRouter().getRoutes(),
    );
  }
}
