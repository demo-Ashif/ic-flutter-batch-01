import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../shared/widgets/app_bar_bottom.dart';
import '../../../shared/widgets/search_button.dart';
import '../controller/product_controller.dart';
import 'dynamic_products_view.dart';

class CategorizedProductsView extends StatefulWidget {
  const CategorizedProductsView(this.category, {super.key});

  final ProductCategoryModel category;

  @override
  State createState() => _CategorizedProductsViewState();
}

class _CategorizedProductsViewState extends State<CategorizedProductsView> {
  final productController = Get.find<ProductController>();
  final familyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Fetch the products by category on page load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts(1);
    });
  }

  Future<void> getProducts(int page) async {
    await productController.fetchProductsByCategory(
      categoryId: widget.category.id!,
      page: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name!),
        bottom: const AppBarBottom(),
        actions: const [SearchButton(padding: EdgeInsets.only(right: 10))],
      ),
      body: SafeArea(
        child: GetBuilder<ProductController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colours.lightThemePrimaryColour,
                ),
              );
            } else if (controller.products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return DynamicProductsView(
              productAdapterFamilyKey: familyKey,
              // products: controller.products,
              fetchRequest: getProducts,
              categorized: false,
            );
          },
        ),
      ),
    );
  }
}
