import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';

import '../controller/cart_controller.dart';

class CartProductTile extends StatelessWidget {
  final CartProductModel product;

  CartProductTile(this.product, {super.key});

  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    // Get the controller

    bool isDisabled = !product.productExists || product.productOutOfStock;

    return AbsorbPointer(
      absorbing: isDisabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        // onLongPress: () => controller.toggleSelection(product.productId),
        onLongPress: () {

        },
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
                          GetBuilder<CartController>(
                            builder: (controller) {
                              // final isSelected = controller.isSelected(product.productId);
                              final isSelected = false;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // int newQuantity = product.quantity +
                                      //     1; // Update quantity logic here
                                      // controller.updateQuantity(
                                      //     product.productId, newQuantity);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  Text(product.quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      // if (product.quantity > 1) {
                                      //   int newQuantity = product.quantity - 1;
                                      //   controller.updateQuantity(
                                      //       product.productId, newQuantity);
                                      // }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  if (isSelected)
                                    IconButton(
                                      // onPressed: () => controller.toggleSelection(product.productId),
                                      onPressed: (){},
                                      icon: const Icon(IconlyLight.tick_square,
                                          color: Colors.green),
                                    )
                                  else
                                    IconButton(
                                      // onPressed: () => controller.removeProduct(product.productId),
                                      onPressed: () {

                                      },
                                      icon: const Icon(IconlyBroken.delete),
                                      color: Colors.red,
                                    ),
                                ],
                              );
                            },
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
                // onPressed: () => controller.removeProduct(product.productId),
                onPressed: () {

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
