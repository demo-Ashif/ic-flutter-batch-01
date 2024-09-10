
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/router/app_router.dart';

class ReactiveCartIcon extends StatefulWidget {
  const ReactiveCartIcon({super.key});

  @override
  State createState() => _HomeAppBarCartIconState();
}

class _HomeAppBarCartIconState extends State<ReactiveCartIcon> {
  final countNotifier = ValueNotifier<int?>(null);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.cartProductScreen),
      child: ValueListenableBuilder(
          valueListenable: countNotifier,
          builder: (_, value, __) {
            return Badge(
              backgroundColor: Colours.lightThemeSecondaryColour,
              label: value == null
                  ? null
                  : Center(
                child: Text(
                  value.toString(),
                  style: const TextStyle().white,
                ),
              ),
              child: Icon(
                IconlyBroken.buy,
                size: 24,
                color: Colours.classicAdaptiveTextColour(context),
              ),
            );
          }),
    );
  }
}
