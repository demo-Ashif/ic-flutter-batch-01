import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:swift_shop/core/extensions/string_extensions.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/features/products/domain/product_model.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../../core/utils/core_utils.dart';
import 'color_pallete_widget.dart';
import 'favorite_icon.dart';

class HomeProductItem extends StatelessWidget {
  const HomeProductItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/products/${product.id}'),
      child: Container(
        height: 228,
        width: 196,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CoreUtils.adaptiveColour(
            context,
            lightModeColour: Colours.lightThemeWhiteColour,
            darkModeColour: Colours.darkThemeDarkSharpColour,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                      height: 131,
                      width: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                        ),
                      )),
                  Positioned(
                      right: 0, child: FavouriteIcon(productId: product.id)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name.truncateWithEllipsis(12),
                    maxLines: 1,
                    style: TextStyles.headingMedium4.adaptiveColour(context),
                  ),
                  Flexible(
                    child: ColourPalette(
                      colours: product.colours.take(3).toList(),
                      radius: 8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5).copyWith(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyles.paragraphSubTextRegular3.orange,
                  ),
                  const Gap(6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colours.lightThemeYellowColour,
                        size: 11,
                      ),
                      const Gap(3),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: TextStyles.paragraphSubTextRegular2
                            .adaptiveColour(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
