import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swift_shop/features/auth/presentation/screens/login_screen.dart';
import 'package:swift_shop/features/auth/presentation/screens/register_screen.dart';
import 'package:swift_shop/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:swift_shop/features/explore/presentation/screens/explore_screen.dart';
import 'package:swift_shop/features/home/presentation/screens/home_screen.dart';
import 'package:swift_shop/features/onboarding/views/onboarding_screen.dart';
import 'package:swift_shop/features/products/presentation/screens/product_detail_screen.dart';
import 'package:swift_shop/features/profile/presentation/screens/profile_screen.dart';
import 'package:swift_shop/features/wishlist/presentation/screens/wishlist_screen.dart';

/// For routes that should NOT have the bottom nav bar
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        redirect: (context, state) {
          if (state.extra == 'home') {
            return HomeScreen.path;
          }
          return null;
        },
        builder: (context, state) => const OnboardingScreen()),
    GoRoute(
        path: LoginScreen.path,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: RegisterScreen.path,
        builder: (context, state) => const RegisterScreen()),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DashboardScreen(
            state: state,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: HomeScreen.path,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: ExploreScreen.path,
            builder: (context, state) => const ExploreScreen(),
          ),
          GoRoute(
            path: WishlistScreen.path,
            builder: (context, state) => const WishlistScreen(),
          ),
          GoRoute(
            path: ProfileScreen.path,
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
    GoRoute(
        path: '/products/:productId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return ProductDetailScreen(
            productId: state.pathParameters['productId'] as String,
          );
        }),
  ],
);
