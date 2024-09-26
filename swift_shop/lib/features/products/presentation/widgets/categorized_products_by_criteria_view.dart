import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/utils/enums/product_criteria_enum.dart';
import '../../../shared/widgets/classic_product_tile.dart';
import '../../../shared/widgets/empty_data.dart';
import '../controller/selected_category_controller.dart';
import '../controller/product_controller.dart';

class CategorizedProductsByCriteriaView extends StatefulWidget {
  const CategorizedProductsByCriteriaView({
    required this.categoryAdapterFamilyKey,
    required this.productCriteria,
    super.key,
  }) : assert(productCriteria == ProductCriteria.newArrivals ||
      productCriteria == ProductCriteria.popular);

  final GlobalKey categoryAdapterFamilyKey;
  final ProductCriteria productCriteria;

  @override
  State createState() => _DynamicProductsViewState();
}

class _DynamicProductsViewState extends State<CategorizedProductsByCriteriaView> {
  final familyKey = GlobalKey();
  int page = 1;

  final ProductController productController = Get.find<ProductController>();
  final SelectedCategoryController selectedCategoryController = Get.find<SelectedCategoryController>();

  Future<void> getProducts() async {
    if (widget.productCriteria == ProductCriteria.newArrivals) {
      return productController.fetchNewArrivals(page: page);
    }
    return productController.fetchPopular(page: page);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts();
    });
  }

  Widget body({
    required ProductController productController,
    required ProductCategoryModel category,
  }) {
    if (productController.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colours.lightThemePrimaryColour,
        ),
      );
    } else if (productController.products.isNotEmpty) {
      var products = productController.products;
      if (category.name != 'All') {
        products.assignAll(products.where((product) => product.category.id == category.id).toList());

      }
      if (products.isEmpty) {
        return const Center(child: EmptyData('No Products Found'));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              runSpacing: 10,
              runAlignment: WrapAlignment.center,
              spacing: 10,
              children: products.map((product) => ClassicProductTile(product)).toList(),
            ),
          ),
        ),
      );
    } else if (productController.errorMessage.isNotEmpty) {
      return const EmptyData('No Products Found');
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (productController) {
        return RefreshIndicator(
          onRefresh: getProducts,
          child: body(
            productController: productController,
            category: selectedCategoryController.selectedCategory.value,
          ),
        );
      },
    );
  }
}
