import 'package:get/get.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

class SelectedCategoryController extends GetxController {
  var selectedCategory = const ProductCategoryModel.all().obs; // Use obs for reactivity

  void changeCategory(ProductCategoryModel category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
    }
  }

  ProductCategoryModel get defaultCategory => const ProductCategoryModel.all();
}
