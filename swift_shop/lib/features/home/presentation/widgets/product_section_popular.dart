import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../products/presentation/controller/product_controller.dart';
import '../../../shared/widgets/empty_data.dart';
import 'home_product_tile.dart';

class ProductsSectionPopular extends StatefulWidget {
  const ProductsSectionPopular.newArrivals({super.key, this.onViewAll})
      : sectionTitle = 'New Arrivals',
        productsCriteria = 'newArrivals';

  const ProductsSectionPopular.popular({super.key, this.onViewAll})
      : sectionTitle = 'Popular Products',
        productsCriteria = 'popular';

  final String sectionTitle;
  final String productsCriteria;
  final VoidCallback? onViewAll;

  @override
  State<ProductsSectionPopular> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductsSectionPopular> {
  final familyKey = GlobalKey();
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.productsCriteria == 'popular') {
        productController.fetchPopular(page: 1);
      } else if (widget.productsCriteria == 'newArrivals') {
        productController.fetchNewArrivals(page: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colours.lightThemePrimaryColour,
            ),
          );
        } else if (controller.products.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.sectionTitle,
                    style: TextStyles.buttonTextHeadingSemiBold.adaptiveColour(context),
                  ),
                  if (controller.products.length > 10)
                    IconButton(
                      onPressed: widget.onViewAll,
                      icon: const Icon(
                        IconlyBroken.arrow_right,
                        color: Colours.lightThemeSecondaryColour,
                      ),
                    ),
                ],
              ),
              const Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.products.take(10).mapIndexed((index, product) {
                    final isLast = index == controller.products.take(10).length - 1;
                    return GestureDetector(
                      onTap: () {
                        // Navigate to product details or perform an action
                      },
                      child: HomeProductTile(
                        product,
                        margin: isLast ? null : const EdgeInsets.only(right: 10),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else {
          return const EmptyData('No products found');
        }
      },
    );
  }
}
