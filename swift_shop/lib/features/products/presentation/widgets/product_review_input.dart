import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:swift_shop/core/extensions/double_extensions.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/extensions/widget_extensions.dart';
import 'package:swift_shop/features/auth/presentation/controllers/auth_controller.dart';
import 'package:swift_shop/features/products/domain/models/product_model.dart';
import 'package:swift_shop/features/profile/presentation/controller/profile_controller.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../shared/widgets/input_field.dart';
import '../controller/product_controller.dart';

class ProductReviewInput extends StatefulWidget {
  const ProductReviewInput(
    this.product, {
    super.key,
  });

  final ProductModel product;

  @override
  State<ProductReviewInput> createState() => _ProductReviewInputState();
}

class _ProductReviewInputState extends State<ProductReviewInput> {
  final ratingNotifier = ValueNotifier<double>(0);
  final controller = TextEditingController();

  final ProductController productController = Get.find<ProductController>();
  final AuthController userController = Get.find<AuthController>();

  @override
  void dispose() {
    controller.dispose();
    ratingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (productController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<AuthController>(
              builder: (userController) {
                if (userController.user != null) {
                  final user = userController.user!;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colours.lightThemePrimaryColour,
                        child: Center(
                          child: Text(
                            '${user.value?.name}',
                            style: TextStyles.headingMedium4.white,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.value?.name}',
                              style: TextStyles.headingSemiBold1
                                  .adaptiveColour(context),
                            ),
                            const Gap(5),
                            Text(
                              'Reviews are public and include your account info.',
                              style: TextStyles.paragraphSubTextRegular3
                                  .adaptiveColour(context)
                                  .copyWith(fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const Gap(15),
            ValueListenableBuilder(
              valueListenable: ratingNotifier,
              builder: (_, value, __) {
                return Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: RatingStars(
                    value: value,
                    onValueChanged: (newValue) {
                      ratingNotifier.value = newValue;
                    },
                    starBuilder: (index, color) {
                      return Icon(
                        value.canFill(index + 1)
                            ? Icons.star
                            : Icons.star_outline,
                        color: color,
                      );
                    },
                    starCount: 5,
                    starSize: 30,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0,
                    ),
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 4,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: const Duration(seconds: 1),
                    valueLabelPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: Colors.grey,
                    starColor: Colors.amber,
                  ),
                );
              },
            ),
            const Gap(25),
            InputField(
              controller: controller,
              expandable: true,
              hintText: 'Describe your experience',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            const Gap(16),
            GetBuilder<AuthController>(
              builder: (userController) {
                if (userController.user != null) {
                  final user = userController.user.value!;
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colours.lightThemePrimaryColour,
                      foregroundColor: Colours.lightThemeWhiteColour,
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (controller.text.trim().isNotEmpty ||
                          ratingNotifier.value >= 1) {
                        productController.leaveReview(
                          productId: widget.product.id,
                          userId: user.id,
                          comment: controller.text.trim(),
                          rating: ratingNotifier.value < 1
                              ? 1
                              : ratingNotifier.value,
                        );
                      }
                    },
                    child: const Text('POST'),
                  ).loading(productController.isReviewing.value);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
