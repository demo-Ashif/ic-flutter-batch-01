import 'package:flutter/material.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../core/res/styles/colors.dart';
import '../../../core/res/styles/text.dart';

class SwiftShop extends StatelessWidget {
  const SwiftShop({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Swift',
        style: style ?? TextStyles.appLogo.white,
        children: const [
          TextSpan(
            text: 'Shop',
            style: TextStyle(color: Colours.lightThemeSecondaryColour),
          ),
        ],
      ),
    );
  }
}
