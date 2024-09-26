import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:swift_shop/core/extensions/int_extensions.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/media.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../../../shared/widgets/search_button.dart';
import '../controller/cart_controller.dart';
import '../utils/cart_utils.dart';
import '../widgets/cart_product_title.dart';
import '../widgets/checkout_all_toggle_button.dart';
import '../widgets/checkout_button.dart';

class CartProductsView extends StatefulWidget {
  const CartProductsView({super.key});

  static const path = '/cart';

  @override
  State<CartProductsView> createState() => _CartProductsViewState();
}

class _CartProductsViewState extends State<CartProductsView> {
  bool removingBulkProducts = false;
  final CartController cartController = Get.find<CartController>();

  Future<void> getCart() async {
    final userId = sl<CacheHelper>().getUserId();
    await cartController.fetchCart('$userId');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        if (removingBulkProducts || controller.isLoading.value) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colours.lightThemePrimaryColour,
              ),
            ),
          );
        } else if (controller.cartProducts.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Cart'),
              bottom: const AppBarBottom(),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(Media.emptyCart, repeat: false),
                    const Gap(5),
                    Text(
                      'Oh! So empty',
                      style: TextStyles.headingSemiBold.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Cart'),
            bottom: const AppBarBottom(),
            actions: [
              const SearchButton(),
              const Gap(5),
              if (controller.selectedProducts.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    setState(() {
                      removingBulkProducts = true;
                    });
                    final shouldDelete = await CartUtils.verifyDeletion(
                      context,
                      message: 'Are you sure you want to remove these items?',
                    );

                    if (shouldDelete) {
                      for (final productId in controller.selectedProducts) {
                        await controller.removeFromCart(
                          userId: '${sl<CacheHelper>().getUserId()}',
                          cartProductId: productId,
                        );
                      }
                    }
                    setState(() {
                      removingBulkProducts = false;
                    });
                  },
                  icon: const Icon(IconlyBroken.delete),
                  color: Colours.lightThemeSecondaryColour,
                ),
              const Gap(10),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.cartProducts.length.pluralizeWith('item'),
                        style: TextStyles.buttonTextHeadingSemiBold
                            .adaptiveColour(context),
                      ),
                      if (controller.cartProducts.isNotEmpty)
                        CheckoutAllToggleButton(
                          allProducts: controller.cartProducts,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.cartProducts[index];
                      return CartProductTile(product);
                    },
                    separatorBuilder: (_, __) => const Gap(20),
                  ),
                ),
                CheckoutButton(products: controller.cartProducts),
              ],
            ),
          ),
        );
      },
    );
  }
}


