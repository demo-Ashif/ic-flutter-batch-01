import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swift_shop/features/auth/views/login_screen.dart';
import 'package:swift_shop/features/auth/views/register_screen.dart';
import 'package:swift_shop/features/onboarding/views/onboarding_screen.dart';

/// For routes that should NOT have the bottom nav bar
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: LoginScreen.path, builder: (context, state) => const LoginScreen()),
    GoRoute(path: RegisterScreen.path, builder: (context, state) => const RegisterScreen()),
  ],
);
