import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/features/explore/presentation/screens/explore_screen.dart';
import 'package:swift_shop/features/home/presentation/screens/home_screen.dart';
import 'package:swift_shop/features/profile/presentation/screens/profile_screen.dart';
import 'package:swift_shop/features/wishlist/presentation/screens/wishlist_screen.dart';

abstract class DashboardUtils {
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  static final iconList = [
    (IconlyBroken.home, IconlyBold.home),
    (IconlyBroken.discovery, IconlyBold.discovery),
    (IconlyBroken.heart, IconlyBold.heart),
    (IconlyBroken.profile, IconlyBold.profile),
  ];

  static int activeIndex(GoRouterState state) {
    return switch (state.fullPath) {
      HomeScreen.path => 0,
      ExploreScreen.path => 1,
      WishlistScreen.path => 2,
      ProfileScreen.path => 3,
      _ => 0,
    };
  }
}
