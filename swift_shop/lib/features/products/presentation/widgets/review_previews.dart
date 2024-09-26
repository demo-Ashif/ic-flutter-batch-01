import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/products/domain/models/product_model.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../controller/product_controller.dart';
import 'product_review_input.dart';
import 'review_tile.dart';

class ReviewsPreview extends StatefulWidget {
  const ReviewsPreview({required this.product, super.key});

  final ProductModel product;

  @override
  State createState() => _ReviewsPreviewState();
}

class _ReviewsPreviewState extends State<ReviewsPreview> {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductReviews(
        productId: widget.product.id,
        page: 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductReviewInput(widget.product),
            const Gap(50),
            Builder(
              builder: (_) {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colours.lightThemePrimaryColour,
                    ),
                  );
                } else if (controller.reviews.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Reviews',
                            style: TextStyles.headingMedium3.adaptiveColour(context),
                          ),
                          if (controller.reviews.length > 4)
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  '/products/${widget.product.id}/reviews',
                                  arguments: widget.product, // Pass product as argument
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyles.paragraphSubTextRegular1.orange,
                              ),
                            ),
                        ],
                      ),
                      const Gap(20),
                      ...controller.reviews.take(4).mapIndexed((index, review) {
                        final lastReviewIndex = controller.reviews.take(4).length - 1;
                        return ReviewTile.preview(
                          review,
                          margin: index == lastReviewIndex ? null : const EdgeInsets.only(bottom: 35),
                        );
                      }),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
