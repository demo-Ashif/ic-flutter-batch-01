import 'package:get/get.dart';
import 'package:swift_shop/features/products/domain/repo/product_repo.dart';

import '../../domain/models/product_category.dart';

class ProductCategoryController extends GetxController {
  final ProductRepo _repo;

  ProductCategoryController(this._repo);

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var categories = <ProductCategoryModel>[].obs;

  /// Fetch the product categories
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final result = await _repo.getCategories();
      result.fold(
            (failure) {
          errorMessage.value = failure.errorMessage;
        },
            (fetchedCategories) {
          categories.value = fetchedCategories;
        },
      );
    } finally {
      isLoading.value = false;
      update(); // Notify GetBuilder widgets to refresh
    }
  }
}
