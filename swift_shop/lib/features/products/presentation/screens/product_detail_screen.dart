import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:swift_shop/core/extensions/context_extensions.dart';
import 'package:swift_shop/features/products/presentation/screens/popular_product_screen.dart';
import 'package:swift_shop/features/products/presentation/widgets/favorite_icon.dart';
import 'package:swift_shop/features/shared/widgets/app_bar_bottom.dart';

import '../../../cart/presentation/widgets/cart_icon_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final product = products[0];

  @override
  void initState() {
    super.initState();

    //TODO: api call using product id
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        bottom: AppBarBottom(),
        //fav icon, cart icon
        actions: [
          FavouriteIcon(productId: widget.productId),
          ReactiveCartIcon()
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: context.height * 0.4,
              autoPlay: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),

            items: products.map((product){
              return Builder(builder: (context){
                return Container(
                  width: context.width,
                  decoration: BoxDecoration(
                    color: const Color(0xfff0f0f0),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                    ),
                  ),
                );
              });
            }).toList(),
          )
          //name
          //price
          //colors
          //sizes
          //reviews
        ],
      ),
    );
  }
}
