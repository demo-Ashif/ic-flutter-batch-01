import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:swift_shop/core/extensions/int_extensions.dart';
import 'package:swift_shop/core/extensions/text_style_extensions.dart';
import 'package:swift_shop/core/router/app_router.dart';
import 'package:swift_shop/core/utils/constants/network_constants.dart';
import 'package:swift_shop/features/cart/presentation/controller/cart_controller.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/res/styles/colors.dart';
import '../../../../core/res/styles/text.dart';
import '../../../../core/utils/core_utils.dart';
import '../../../cart/domain/models/cart_product_model.dart';
import '../../../cart/presentation/widgets/cart_icon_widget.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../../../shared/widgets/expandable_text.dart';
import '../../../shared/widgets/rounded_button.dart';
import '../controller/product_controller.dart';
import '../widgets/color_pallete_widget.dart';
import '../widgets/favorite_icon.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(this.productId, {super.key});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedSize;
  Color? selectedColour;

  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
            bottom: const AppBarBottom(),
            actions: [
              if (controller.productDetail.value != null)
                FavouriteIcon(productId: controller.productDetail.value.id),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: ReactiveCartIcon(),
              )
            ],
          ),
          body: Builder(
            builder: (context) {
              if (controller.isLoadingProductDetail.value) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colours.lightThemePrimaryColour,
                  ),
                );
              } else if (controller.productDetail.value != null) {
                final product = controller.productDetail.value!;
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // images
                          Builder(builder: (context) {
                            var images = product.images;
                            if (images.isEmpty) images = [product.image];
                            return CarouselSlider(
                              options: CarouselOptions(
                                height: context.height * .4,
                                autoPlay: images.length > 1,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                              ),
                              items: images.map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: context.width,
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff0f0f0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${NetworkConstants.imageBaseUrl}/$image'),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          }),
                          // name and price
                          Padding(
                            padding:
                                const EdgeInsets.all(20).copyWith(bottom: 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        style: TextStyles.headingMedium4
                                            .adaptiveColour(context),
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyles.headingMedium1.orange,
                                    ),
                                  ],
                                ),
                                const Gap(5),
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
                                    Text(
                                      ' (${product.numberOfReviews.pluralizeReviews})',
                                      style: const TextStyle(
                                        color: Colours
                                            .lightThemeSecondaryTextColour,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: CoreUtils.adaptiveColour(
                              context,
                              darkModeColour: Colours.darkThemeDarkSharpColour,
                              lightModeColour: Colors.white,
                            ),
                          ),
                          const Gap(10),
                          // description
                          Padding(
                            padding: const EdgeInsets.all(20).copyWith(top: 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (product.colours.isNotEmpty)
                                  ColourPalette(
                                    colours: product.colours,
                                    canScroll: true,
                                    radius: 15,
                                    spacing: 10,
                                    padding: const EdgeInsets.all(5),
                                    onSelect: (colour) {
                                      selectedColour = colour;
                                    },
                                  ),
                                if (product.sizes.isNotEmpty) ...[
                                  const Gap(15),
                                  SizePicker(
                                    sizes: product.sizes,
                                    radius: 28,
                                    canScroll: true,
                                    spacing: 8,
                                    onSelect: (size) {
                                      selectedSize = size;
                                    },
                                  ),
                                ],
                                const Gap(20),
                                Text(
                                  'Description',
                                  style: TextStyles.headingMedium3
                                      .adaptiveColour(context),
                                ),
                                const Gap(5),
                                ExpandableText(
                                  context,
                                  text: product.description,
                                  style: TextStyles.paragraphRegular.grey,
                                ),
                                const Gap(30),
                                // ReviewsPreview(product: product),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // add to cart
                    Padding(
                      padding: const EdgeInsets.all(20).copyWith(bottom: 40),
                      child: RoundedButton(
                        height: 50,
                        onPressed: () {
                          if (product.colours.isNotEmpty &&
                              selectedColour == null) {
                            CoreUtils.showSnackBar(
                              context,
                              message: 'Pick a colour',
                              backgroundColour: Colors.red.withOpacity(.8),
                            );
                            return;
                          } else if (product.sizes.isNotEmpty &&
                              selectedSize == null) {
                            CoreUtils.showSnackBar(
                              context,
                              message: 'Pick a size',
                              backgroundColour: Colors.red.withOpacity(.8),
                            );
                            return;
                          }

                          // Add product to cart
                          cartController.addToCart(
                            userId: '${sl<CacheHelper>().getUserId()}',
                            cartProductModel:
                                const CartProductModel.empty().copyWith(
                              productId: product.id,
                              quantity: 1,
                              selectedSize: selectedSize,
                              selectedColour: selectedColour,
                            ),
                          );
                        },
                        text: 'Add to Cart',
                        textStyle: TextStyles.buttonTextHeadingSemiBold
                            .copyWith(fontSize: 16)
                            .white,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
