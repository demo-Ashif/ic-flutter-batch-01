import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../../core/utils/core_utils.dart';
import '../controller/cart_controller.dart';
import 'cart_product_quantity_stepper_icon.dart';

class CartProductQuantityStepper extends StatefulWidget {
  const CartProductQuantityStepper(
      this.initialQuantity, {
        required this.counterKey,
        required this.cartProductId,
        required this.onStep,
        super.key,
      });

  final int initialQuantity;
  final GlobalKey counterKey;
  final String cartProductId;
  final void Function(int? newQuantity) onStep;

  @override
  State createState() => _CartProductQuantityStepperState();
}

class _CartProductQuantityStepperState extends State<CartProductQuantityStepper> {
  late int initialQuantity;
  late ValueNotifier<int> quantityNotifier;

  final CartController cartController = Get.find<CartController>();

  void getCartProduct() {
    cartController.fetchCartProduct(
      userId: '${sl<CacheHelper>().getUserId()}',
      cartProductId: widget.cartProductId,
    );
  }

  @override
  void initState() {
    super.initState();
    initialQuantity = widget.initialQuantity;
    quantityNotifier = ValueNotifier(widget.initialQuantity)
      ..addListener(() {
        if (quantityNotifier.value != initialQuantity) {
          widget.onStep(quantityNotifier.value);
        } else {
          widget.onStep(null);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        if (controller.isProductBeingUpdated(widget.cartProductId)) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colours.lightThemePrimaryColour,
            ),
          );
        } else {
          return SizedBox(
            width: 127,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: ColoredBox(
                color: CoreUtils.adaptiveColour(
                  context,
                  lightModeColour: const Color(0xffEEEFF2),
                  darkModeColour: Colours.darkThemeDarkSharpColour,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CartProductQuantityStepperIcon.decrement(
                      onTap: () {
                        if (quantityNotifier.value > 1) {
                          quantityNotifier.value--;
                        }
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: quantityNotifier,
                      builder: (_, value, __) {
                        return Text(
                          value.toString(),
                          style: TextStyles.paragraphSubTextRegular1
                              .adaptiveColour(context),
                        );
                      },
                    ),
                    CartProductQuantityStepperIcon.increment(
                      onTap: () {
                        quantityNotifier.value++;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cartController.addListener(() {
      if (cartController.errorMessage.isNotEmpty) {
        CoreUtils.showSnackBar(context, message: cartController.errorMessage.value);
        getCartProduct();
      } else if (cartController.isLoading.value) {
        CoreUtils.postFrameCall(() {
          widget.onStep(null);
          initialQuantity = cartController.fetchedProduct.value?.quantity ?? initialQuantity;
          quantityNotifier.value = initialQuantity;
        });
      }
    });
  }

  @override
  void dispose() {
    quantityNotifier.dispose();
    super.dispose();
  }
}
