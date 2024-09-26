import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../controller/cart_controller.dart';

class CheckoutAllToggleButton extends StatefulWidget {
  const CheckoutAllToggleButton({required this.allProducts, super.key});

  final List<CartProductModel> allProducts;

  @override
  State createState() => _CheckoutAllToggleButtonState();
}

class _CheckoutAllToggleButtonState extends State<CheckoutAllToggleButton> {
  // Inject the CartController
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    // Determine if all products are checked using GetX state
    final allProductsChecked = cartController.cartProducts.length == widget.allProducts.length;

    return GestureDetector(
      onTap: () {
        if (allProductsChecked) {
          // Deselect all products
          cartController.deselectAllProducts();
        } else {
          // Select all products
          cartController.selectAllProducts(widget.allProducts.map((product) => product.id).toList());
        }
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          allProductsChecked ? Colours.lightThemeSecondaryColour : Colors.transparent,
          BlendMode.srcATop,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Checkout all',
              style: TextStyles.paragraphSubTextRegular1.grey,
            ),
            const Gap(10),
            const Icon(
              IconlyLight.tick_square,
              color: Colours.lightThemeSecondaryTextColour,
            ),
          ],
        ),
      ),
    );
  }
}
