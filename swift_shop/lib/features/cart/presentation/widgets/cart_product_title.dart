import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../controller/cart_controller.dart';

class CartProductTile extends StatelessWidget {
  final CartProductModel product;

  CartProductTile(this.product, {super.key});

  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    // Disable actions for out-of-stock or non-existent products
    bool isDisabled = !product.productExists || product.productOutOfStock;

    return AbsorbPointer(
      absorbing: isDisabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
                      onTap: () {
                        if (product.productExists) {
                          Get.toNamed('/products/${product.productId}');
                        }
                      },
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
                            onTap: () {
                              if (product.productExists) {
                                Get.toNamed('/products/${product.productId}');
                              }
                            },
                            child: Text(
                              product.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${product.productPrice.toStringAsFixed(2)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 16),
                              ),
                            ],
                          ),
                          if (product.selectedSize != null)
                            Text('Size: ${product.selectedSize}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Increase quantity
                                  controller.changeCartProductQuantity(
                                    userId: '${sl<CacheHelper>().getUserId()}', // Replace with actual userId
                                    cartProductId: product.productId,
                                    newQuantity: product.quantity + 1,
                                  );
                                },
                                icon: const Icon(Icons.add),
                              ),
                              Text(product.quantity.toString()),
                              IconButton(
                                onPressed: () {
                                  if (product.quantity > 1) {
                                    // Decrease quantity
                                    controller.changeCartProductQuantity(
                                      userId: '${sl<CacheHelper>().getUserId()}', // Replace with actual userId
                                      cartProductId: product.productId,
                                      newQuantity: product.quantity - 1,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Remove product from cart
                                  controller.removeFromCart(
                                    userId: '${sl<CacheHelper>().getUserId()}', // Replace with actual userId
                                    cartProductId: product.productId,
                                  );
                                },
                                icon: const Icon(IconlyBroken.delete),
                                color: Colors.red,
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
              Text(
                product.productOutOfStock
                    ? 'This product is out of stock'
                    : 'This product no longer exists',
                style: const TextStyle(color: Colors.red),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () {
                  // Remove product if out of stock or doesn't exist
                  controller.removeFromCart(
                    userId: '${sl<CacheHelper>().getUserId()}', // Replace with actual userId
                    cartProductId: product.productId,
                  );
                },
                child: const Text('REMOVE'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

