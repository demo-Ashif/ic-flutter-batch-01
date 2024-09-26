import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:swift_shop/core/extensions/widget_extensions.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';

import 'package:get/get.dart';
import '../../../wishlist/presentation/controller/wishlist_controller.dart';

class FavouriteIcon extends StatefulWidget {
  const FavouriteIcon({required this.productId, super.key});

  final String productId;

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  final WishlistController wishlistController = Get.find<WishlistController>();
  late bool productIsFavourite;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistController>(
      builder: (controller) {
        final userId = '${sl<CacheHelper>().getUserId()}';

        // Check if the product is in the wishlist
        productIsFavourite = controller.wishlist
            .any((product) => product.productId == widget.productId);

        return IconButton(
          onPressed: () async {
            if (productIsFavourite) {
              await wishlistController.removeFromWishlist(
                userId: userId,
                productId: widget.productId,
              );
            } else {
              await wishlistController.addToWishlist(
                userId: userId,
                productId: widget.productId,
              );
            }
          },
          icon: Icon(
            productIsFavourite ? IconlyBold.heart : IconlyBroken.heart,
            color: Colours.lightThemeSecondaryColour,
          ),
        ).loading(controller.isAdding.value || controller.isRemoving.value);
      },
    );
  }
}
