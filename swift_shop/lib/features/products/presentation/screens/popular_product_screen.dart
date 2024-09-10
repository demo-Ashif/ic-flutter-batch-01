import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../domain/models/product_model.dart';
import '../controller/product_controller.dart';
import '../widgets/home_product_item.dart'; // Assuming you use skeleton loader

class PopularProductScreen extends StatefulWidget {
  const PopularProductScreen({super.key});

  @override
  State createState() => _PopularProductScreenState();
}

class _PopularProductScreenState extends State<PopularProductScreen> {
  final ProductController controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    // Fetch popular products in initState
    controller.fetchPopularProducts(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Products',
                  style: TextStyles.buttonTextHeadingSemiBold
                      .adaptiveColour(context),
                  textAlign: TextAlign.start,
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Colours.lightThemeSecondaryTextColour.withOpacity(0.2),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    IconlyBroken.arrow_right,
                    color: Colours.lightThemeSecondaryColour,
                  ),
                ),
              ],
            ),
            const Gap(20),
            // If loading, show skeleton loader, otherwise show products
            controller.isLoadingPopular.value
                ? _buildSkeletonLoader()
                : _buildProductList(controller.popularProducts),

          ],
        );
      },
    );
  }

  // Skeleton loader UI
  Widget _buildSkeletonLoader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Skeletonizer(
            child: Container(
              width: 100,
              height: 150,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Product list UI
  Widget _buildProductList(List<ProductModel> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: products.map((product) {
          return GestureDetector(
            onTap: () {
              // Handle product tap
            },
            child: HomeProductItem(product: product),
          );
        }).toList(),
      ),
    );
  }
}
