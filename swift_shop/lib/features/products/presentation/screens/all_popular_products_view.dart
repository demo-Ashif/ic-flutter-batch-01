import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

import '../../../../core/utils/enums/product_criteria_enum.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../../../shared/widgets/search_button.dart';
import '../controller/selected_category_controller.dart';
import '../widgets/categorized_products_by_criteria_view.dart';
import '../widgets/category_selector.dart';

class AllPopularProductsView extends StatefulWidget {
  const AllPopularProductsView({super.key});

  static const path = 'popular';

  @override
  State createState() => _AllPopularProductsViewState();
}

class _AllPopularProductsViewState extends State<AllPopularProductsView> {
  final categoryNotifierFamilyKey = GlobalKey();
  final SelectedCategoryController selectedCategoryController = Get.find<SelectedCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Products'),
        bottom: const AppBarBottom(),
        actions: const [SearchButton(padding: EdgeInsets.only(right: 10))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
              child: GetBuilder<SelectedCategoryController>(
                builder: (controller) {
                  return CategorySelector(
                    selectedCategory: controller.selectedCategory.value, // Use GetX controller's state
                    onSelected: (category) {
                      controller.changeCategory(category);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: CategorizedProductsByCriteriaView(
                categoryAdapterFamilyKey: categoryNotifierFamilyKey,
                productCriteria: ProductCriteria.popular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
