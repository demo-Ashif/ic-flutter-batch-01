import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/router/app_router.dart';

import 'controller_binder.dart';
import 'core/di/injection_container.dart';
import 'core/res/styles/colors.dart';
import 'features/onboarding/views/onboarding_screen.dart';

Future<void> main() async{
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
      // routerConfig: router,
      title: 'Swift Shop',
      theme: theme,
      home: const OnboardingScreen(),
      initialBinding: ControllerBinder(),
      darkTheme: theme.copyWith(
        scaffoldBackgroundColor: Colours.darkThemeBGDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colours.darkThemeBGDark,
          foregroundColor: Colours.lightThemeWhiteColour,
        ),
      ),
    );
  }
}
