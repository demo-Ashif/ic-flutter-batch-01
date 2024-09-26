import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/extensions/widget_extensions.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../products/presentation/widgets/color_pallete_widget.dart';
import '../controller/cart_controller.dart';
import '../utils/cart_utils.dart';
import 'cart_product_quantity_stepper_icon.dart';
import 'cart_product_quatity_stepper.dart';

class CartProductTile extends StatefulWidget {
  const CartProductTile(
      this.product, {
        super.key,
      });

  final CartProductModel product;

  @override
  State createState() => _CartProductTileState();
}

class _CartProductTileState extends State<CartProductTile> {
  final productQuantityCounterFamilyKey = GlobalKey();
  final quantityUpdateNotifier = ValueNotifier<int?>(null);
  final CartController cartController = Get.find<CartController>();
  late CartProductModel product;

  void goToProductDetails() {
    if (product.productExists) {
      Get.toNamed('/products/${product.productId}');
    }
  }

  void updateQuantity() {
    cartController.changeProductQuantity(
      userId: '${sl<CacheHelper>().getUserId()}',
      cartProductId: product.id,
      newQuantity: quantityUpdateNotifier.value!,
    );
    quantityUpdateNotifier.value = null;
  }

  void selectProduct() {
    cartController.selectProduct(product.id);
  }

  void deselectProduct() {
    cartController.deselectProduct(product.id);
  }

  Future<void> removeFromCart() async {
    final shouldDelete = await CartUtils.verifyDeletion(Get.context!);

    if (shouldDelete) {
      cartController.removeFromCart(
        userId: '${sl<CacheHelper>().getUserId()}',
        cartProductId: product.id,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    bool isDisabled = !product.productExists || product.productOutOfStock;

    return GetBuilder<CartController>(
      builder: (controller) {
        if (controller.isAddingToCart.value || controller.isRemovingFromCart.value) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colours.lightThemePrimaryColour,
            ),
          );
        }

        final allProductsSelected = controller.selectedProducts.contains(product.id);
        final anyProductSelected = controller.selectedProducts.isNotEmpty;

        return AbsorbPointer(
          absorbing: isDisabled,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: selectProduct,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    isDisabled ? Colors.grey : Colors.transparent,
                    BlendMode.saturation,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: goToProductDetails,
                          child: Container(
                            height: 152,
                            width: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xfff0f0f0),
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage('${NetworkConstants.imageBaseUrl}/${product.productImage}'),
                              ),
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: goToProductDetails,
                                child: Text(
                                  product.productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.buttonTextHeadingSemiBold
                                      .adaptiveColour(context),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '\$${product.productPrice.toStringAsFixed(2)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.headingMedium4.orange,
                                  ),
                                  if (product.selectedColour != null) ...[
                                    const Gap(5),
                                    Flexible(
                                      child: ColourPalette(
                                        colours: [product.selectedColour!],
                                        radius: 5,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if (product.selectedSize != null)
                                Text(
                                  'Size: ${product.selectedSize}',
                                  style: TextStyles.paragraphSubTextRegular1
                                      .adaptiveColour(context),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CartProductQuantityStepper(
                                    product.quantity,
                                    counterKey: productQuantityCounterFamilyKey,
                                    cartProductId: product.id,
                                    onStep: (newQuantity) {
                                      quantityUpdateNotifier.value = newQuantity;
                                    },
                                  ),
                                  if (anyProductSelected)
                                    IconButton(
                                      onPressed: allProductsSelected ? deselectProduct : selectProduct,
                                      icon: Icon(
                                        IconlyLight.tick_square,
                                        color: allProductsSelected
                                            ? Colours.lightThemeSecondaryColour
                                            : Colours.lightThemeSecondaryTextColour,
                                      ),
                                    )
                                  else
                                    IconButton(
                                      onPressed: removeFromCart,
                                      icon: const Icon(IconlyBroken.delete),
                                      color: Colours.lightThemeSecondaryColour,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isDisabled) ...[
                  const Gap(10),
                  Builder(
                    builder: (context) {
                      var message = product.productOutOfStock
                          ? 'This product is out of stock'
                          : 'This product no longer exists, Delete it to free up your cart';
                      return Text(
                        message,
                        style: TextStyles.paragraphSubTextRegular2
                            .adaptiveColour(context),
                      );
                    },
                  ),
                  const Gap(10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colours.lightThemeSecondaryColour,
                      foregroundColor: Colours.lightThemeWhiteColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: removeFromCart,
                    child: const Text('REMOVE'),
                  ).loading(controller.isRemovingFromCart.value),
                ],
                ValueListenableBuilder(
                  valueListenable: quantityUpdateNotifier,
                  builder: (_, value, __) {
                    if (value == null) return const SizedBox.shrink();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(10),
                        Text(
                          'Tap to update',
                          style: TextStyles.paragraphSubTextRegular2
                              .adaptiveColour(context),
                        ),
                        const Gap(10),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colours.lightThemePrimaryColour,
                            foregroundColor: Colours.lightThemeWhiteColour,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: updateQuantity,
                          child: const Text('UPDATE'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


