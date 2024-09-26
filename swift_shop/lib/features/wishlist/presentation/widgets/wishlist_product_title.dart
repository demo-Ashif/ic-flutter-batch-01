import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/features/wishlist/domain/models/wishlist_product_model.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../controller/wishlist_controller.dart';


class WishlistProductTile extends StatelessWidget {
  final WishlistProductModel wishlistProduct;

  const WishlistProductTile(this.wishlistProduct, {super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find<WishlistController>();

    return GetBuilder<WishlistController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colours.lightThemeWhiteColour,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Display Product Image
                  Image.network('${NetworkConstants.imageBaseUrl}/${wishlistProduct.productImage}',
                      height: 80, width: 80),
                  const Gap(10),
                  // Display Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(wishlistProduct.productName,
                            style: TextStyles.headingMedium4),
                        Text('\$${wishlistProduct.productPrice}',
                            style: TextStyles.headingMedium4),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remove from Wishlist
                  TextButton(
                    onPressed: () {
                      controller.removeFromWishlist(
                        userId: '${sl<CacheHelper>().getUserId()}',
                        productId: wishlistProduct.productId,
                      );
                    },
                    child: const Text('Remove'),
                  ),
                  // Add to Cart
                  TextButton(
                    onPressed: wishlistProduct.productOutOfStock
                        ? null
                        : () {
                      // Add to Cart Logic Here
                    },
                    child: Text(wishlistProduct.productOutOfStock
                        ? 'OUT OF STOCK'
                        : 'ADD TO CART'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

