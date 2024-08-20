import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/icons/heroicons_outline.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../../core/utils/core_utils.dart';
import '../../../dashboard/presentation/utils/dashboard_utils.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final adaptiveColour = Colours.classicAdaptiveTextColour(context);
    return AppBar(
      leading: Center(
        child: GestureDetector(
          onTap: () {
            DashboardUtils.scaffoldKey.currentState?.openDrawer();
          },
          child: Iconify(
            HeroiconsOutline.menu_alt_2,
            size: 24,
            color: adaptiveColour,
          ),
        ),
      ),
      centerTitle: false,
      titleSpacing: 0,
      title: Text.rich(
        TextSpan(
          text: 'Swift',
          style:TextStyles.headingSemiBold.copyWith(
            color: CoreUtils.adaptiveColour(
              context,
              darkModeColour: Colours.lightThemePrimaryTint,
              lightModeColour: Colours.lightThemePrimaryColour,
            ),
          ),
          children: const [
            TextSpan(
              text: 'Shop',
              style: TextStyle(color: Colours.lightThemeSecondaryColour),
            ),
          ],
        ),
      ),
      bottom: const AppBarBottom(),
      actions: [
        Badge(
          backgroundColor: Colours.lightThemeSecondaryColour,
          alignment: AlignmentDirectional.topStart,
          child: Icon(
            IconlyBroken.notification,
            size: 24,
            color: adaptiveColour,
          ),
        ),
        const Gap(20),
        Icon(IconlyBold.scan, color: adaptiveColour),
        const Gap(20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
