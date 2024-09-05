import 'package:collection/collection.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/context_extensions.dart';
import 'package:swift_shop/features/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:swift_shop/features/explore/presentation/screens/explore_screen.dart';
import 'package:swift_shop/features/home/presentation/screens/home_screen.dart';
import 'package:swift_shop/features/profile/presentation/screens/profile_screen.dart';
import 'package:swift_shop/features/wishlist/presentation/screens/wishlist_screen.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/utils/core_utils.dart';
import '../controller/navigation_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeNavIndex = ref.watch(navigationControllerProvider);

    return Scaffold(
      body: IndexedStack(
        index: activeNavIndex,
        children: const [
          HomeScreen(),
          ExploreScreen(),
          WishlistScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeNavIndex,
        onTap: (index) {
          ref.read(navigationControllerProvider.notifier).changeIndex(index);
        },
        backgroundColor: context.theme.scaffoldBackgroundColor,
        selectedItemColor: Colours.lightThemePrimaryColour,
        unselectedItemColor: Colours.lightThemeSecondaryTextColour,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyBroken.home),
            activeIcon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBroken.discovery),
            activeIcon: Icon(IconlyBold.discovery),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBroken.heart),
            activeIcon: Icon(IconlyBold.heart),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBroken.profile),
            activeIcon: Icon(IconlyBold.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
