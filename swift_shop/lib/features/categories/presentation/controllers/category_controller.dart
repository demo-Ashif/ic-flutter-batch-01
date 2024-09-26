import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:swift_shop/features/categories/domain/repos/category_repo.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

class CategoryController extends GetxController {
  final CategoryRepo _categoryRepository;

  CategoryController(this._categoryRepository);

  var categoriesList = <ProductCategoryModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;



  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      update(); // Notify GetBuilder to show the loading state

      final result = await _categoryRepository.getCategories();

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          update(); // Notify GetBuilder about the error
        },
            (categories) {
          categoriesList.assignAll(categories);
          update(); // Notify GetBuilder about the fetched data
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      update(); // Notify GetBuilder about the error
    } finally {
      isLoading.value = false;
      update(); // Notify GetBuilder about the loading completion
    }
  }
}

