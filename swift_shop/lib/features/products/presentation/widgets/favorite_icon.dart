import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/res/styles/colors.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        false ? IconlyBold.heart : IconlyBroken.heart,
        color: Colours.lightThemeSecondaryColour,
      ),
    );
  }
}
