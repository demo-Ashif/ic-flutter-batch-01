import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:swift_shop/features/home/presentation/widgets/product_section_popular.dart';
import 'package:swift_shop/features/home/presentation/widgets/promo_banner.dart';

import '../../../products/presentation/screens/all_popular_products_view.dart';
import '../../../categories/presentation/widgets/categories_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(20),
            const SearchSection(),
            const Gap(20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const PromoBanner(),
                  const Gap(16),
                  const CategoriesSection(),
                  ProductsSectionPopular.popular(
                    onViewAll: ()=>Get.toNamed(
                        '${HomeScreen.path}/${AllPopularProductsView.path}'),
                  )
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
