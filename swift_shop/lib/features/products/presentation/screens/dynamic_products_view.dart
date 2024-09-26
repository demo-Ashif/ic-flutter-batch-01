import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';
import 'package:swift_shop/features/products/domain/models/product_model.dart';

import '../../../../core/res/styles/colors.dart';
import '../../../../core/utils/constants/network_constants.dart';
import '../../../shared/widgets/classic_product_tile.dart';
import '../../../shared/widgets/empty_data.dart';
import '../controller/selected_category_controller.dart';
import '../controller/product_controller.dart';

class DynamicProductsView extends StatefulWidget {
  const DynamicProductsView({
    required this.productAdapterFamilyKey,
    this.categoryFamilyKey,
    required this.fetchRequest,
    this.categorized = true,
    super.key,
  }) : assert(
          !categorized || (categorized && categoryFamilyKey != null),
          'Category family key cannot be null in a "Categorized" products view',
        );

  final GlobalKey productAdapterFamilyKey;
  final GlobalKey? categoryFamilyKey;
  final ValueChanged<int> fetchRequest;
  final bool categorized;

  @override
  State<DynamicProductsView> createState() => _DynamicProductsView();
}

class _DynamicProductsView extends State<DynamicProductsView> {
  final pageController = PagingController<int, ProductModel>(firstPageKey: 1);
  final productController = Get.find<ProductController>();
  final selectedCategoryController = Get.find<SelectedCategoryController>();

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    pageController.addPageRequestListener((pageKey) {
      currentPage = pageKey;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.fetchRequest(pageKey);
      });
    });

    // Listen to product changes
    ever(productController.products, (List<ProductModel> products) {
      final isLastPage = products.length < NetworkConstants.pageSize;
      if (isLastPage) {
        pageController.appendLastPage(products);
      } else {
        final nextPage = currentPage + 1;
        pageController.appendPage(products, nextPage);
      }
    });

    // Listen to error changes
    ever(productController.errorMessage, (String? error) {
      if (error != null) {
        pageController.error = error;
        Get.snackbar(
          "Error",
          "$error\nPULL TO REFRESH",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });

    // Listen to category changes
    ever(selectedCategoryController.selectedCategory,
        (ProductCategoryModel category) {
      currentPage = 1;
      pageController.refresh();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => pageController.refresh(),
      ),
      child: PagedMasonryGridView<int, ProductModel>.count(
        pagingController: pageController,
        crossAxisCount: 2,
        builderDelegate: PagedChildBuilderDelegate<ProductModel>(
          itemBuilder: (context, product, index) => Center(
            child: ClassicProductTile(product),
          ),
          firstPageProgressIndicatorBuilder: (_) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colours.lightThemePrimaryColour,
              ),
            );
          },
          newPageProgressIndicatorBuilder: (_) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colours.lightThemePrimaryColour,
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            final categorySelected = widget.categorized &&
                selectedCategoryController.selectedCategory.value.name
                        ?.toLowerCase() !=
                    'all';
            return Center(
              child: EmptyData(
                categorySelected
                    ? 'No products found for this category'
                    : 'No products found',
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
