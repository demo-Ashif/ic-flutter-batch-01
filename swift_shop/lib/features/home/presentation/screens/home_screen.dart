import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:swift_shop/features/home/presentation/widgets/promo_banner.dart';

import '../../../products/presentation/screens/popular_product_screen.dart';
import '../../../categories/presentation/widgets/categories_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Gap(20),
            SearchSection(),
            Gap(20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  PromoBanner(),
                  Gap(16),
                  CategoriesSection(),
                  PopularProductScreen()
                  //new arrivals
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
