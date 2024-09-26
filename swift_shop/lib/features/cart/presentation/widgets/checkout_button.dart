import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/extensions/widget_extensions.dart';
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';

import '../../../../core/res/styles/text.dart';
import '../../../shared/widgets/rounded_button.dart';
import '../controller/cart_controller.dart';

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({required this.products, super.key});

  final List<CartProductModel> products;

  @override
  State createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    // Access selected products using GetX
    final selectedProducts = widget.products.where(
      (product) => cartController.selectedProducts.contains(product.id),
    );

    // Calculate total
    double total = selectedProducts.isEmpty
        ? widget.products.fold<double>(
            0,
            (value, product) =>
                value + (product.productPrice * product.quantity),
          )
        : selectedProducts.fold<double>(
            0,
            (value, product) =>
                value + (product.productPrice * product.quantity),
          );

    return GetBuilder<CartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 40),
          child: RoundedButton(
            height: 50,
            onPressed: () {
              // Use GetX CartController to initiate checkout
              cartController.initiateCheckout(
                theme: Get.isDarkMode ? 'dark' : 'light',
                cartItems: selectedProducts.isEmpty
                    ? widget.products
                    : selectedProducts.toList(),
              );
            },
            text: 'Checkout (\$${total.toStringAsFixed(2)})',
            textStyle: TextStyles.buttonTextHeadingSemiBold
                .copyWith(fontSize: 16)
                .white,
          ).loading(controller.isLoading.value),
        );
      },
    );
  }
}
