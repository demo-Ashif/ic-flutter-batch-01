import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/products/presentation/widgets/home_product_item.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../domain/product_model.dart';

final List<ProductModel> products = [
  ProductModel.empty(),
  ProductModel.empty(),
  ProductModel.empty(),
  ProductModel.empty(),
  ProductModel.empty(),
];

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Gap(20),
            Text(
              'Popular Products',
              style:
                  TextStyles.buttonTextHeadingSemiBold.adaptiveColour(context),
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
        //products list (horizontally)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: products.mapIndexed((index, product) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  //TODO
                },
                child: HomeProductItem(product: product),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
