import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../controller/wishlist_controller.dart';

class FavouriteIcon extends StatefulWidget {
  const FavouriteIcon({required this.productId, super.key});

  final String productId;

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  late bool productIsFavourite;

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();

    return Obx(() {
      final isFavourite = wishlistController.wishlist.any(
              (product) => product.productId == widget.productId);

      return IconButton(
        onPressed: () {
          if (isFavourite) {
            wishlistController.removeFromWishlist(
              userId: '${sl<CacheHelper>().getUserId()}',
              productId: widget.productId,
            );
          } else {
            wishlistController.addToWishlist(
              userId: '${sl<CacheHelper>().getUserId()}',
              productId: widget.productId,
            );
          }
        },
        icon: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          color: Colours.lightThemeSecondaryColour,
        ),
      );
    });
  }
}
