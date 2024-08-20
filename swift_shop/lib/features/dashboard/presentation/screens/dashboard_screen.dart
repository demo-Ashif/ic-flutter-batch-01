import 'package:collection/collection.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  const DashboardScreen({
    super.key,
    required this.state,
    required this.child,
  });

  final Widget child;
  final GoRouterState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = DashboardUtils.activeIndex(state);
    final activeNavIndex = ref.watch(navigationControllerProvider);
    return Scaffold(
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: activeNavIndex,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        color: CoreUtils.adaptiveColour(
          context,
          lightModeColour: Colours.lightThemeWhiteColour,
          darkModeColour: Colours.darkThemeDarkSharpColour,
        ),
        buttonBackgroundColor: Colours.lightThemePrimaryColour,
        items: DashboardUtils.iconList.mapIndexed((index, icon) {
          final isActive = activeIndex == activeNavIndex;
          return Icon(
            isActive ? icon.$2 : icon.$1,
            size: 30,
            color: isActive
                ? Colours.lightThemeWhiteColour
                : Colours.lightThemeSecondaryTextColour,
          );
        }).toList(),
        onTap: (index) {
          final router = GoRouter.of(context);
          final currentIndex = activeNavIndex;

          ref.read(navigationControllerProvider.notifier).changeIndex(index);

          switch (index) {
            case 0:
              context.go(HomeScreen.path);
              break;
            case 1:
              context.go(ExploreScreen.path);
              break;
            case 2:
              context.go(WishlistScreen.path);
              break;
            case 3:
              context.go(ProfileScreen.path);
              break;
          }
        },
      ),
    );
  }
}
