import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../../../shared/widgets/search_button.dart';
import '../controller/cart_controller.dart';
import '../utils/cart_utils.dart';
import '../widgets/cart_product_title.dart';

class CartProductScreen extends StatefulWidget {
  const CartProductScreen({super.key});

  @override
  State<CartProductScreen> createState() => _CartProductScreenState();
}

class _CartProductScreenState extends State<CartProductScreen> {
  final CartController cartController = Get.find<CartController>();

  Future<void> getCart() async {
    final userId = sl<CacheHelper>().getUserId();
    await cartController.getCartProducts(userId!);
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
        return RefreshIndicator.adaptive(
          onRefresh: getCart,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('My Cart'),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBarBottom(),
              ),
              actions: [
                const SearchButton(),
                const Gap(5),
                if (controller.cartProducts.isNotEmpty)
                  IconButton(
                    onPressed: () async {
                      final shouldDelete = await CartUtils.verifyDeletion(
                        context,
                        message: 'Are you sure you want to remove these items?',
                      );
                      if (shouldDelete) {
                        // Remove all selected products
                        for (final product in controller.cartProducts) {
                          await controller.removeFromCart(
                            userId: sl<CacheHelper>().getUserId()!,
                            cartProductId: product.productId,
                          );
                        }
                      }
                    },
                    icon: const Icon(IconlyBroken.delete),
                    color: Colours.lightThemeSecondaryColour,
                  ),
                const Gap(10),
              ],
            ),
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colours.lightThemePrimaryColour,
                      ),
                    );
                  }

                  if (controller.cartProducts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset('assets/lottie/empty_cart.json', repeat: false),
                            const Gap(5),
                            const Text(
                              'Oh! So empty',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${controller.cartProducts.length} item(s)',
                              style: const TextStyle(fontWeight: FontWeight.bold),
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
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

