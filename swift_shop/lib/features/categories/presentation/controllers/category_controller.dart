import 'package:get/get.dart';
import 'package:swift_shop/features/categories/domain/repos/category_repo.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';

class CategoryController extends GetxController {
  final CategoryRepo _repo;

  CategoryController(this._repo);

  // Observables for managing state
  var isLoading = false.obs;
  var categoriesList = Rxn<List<ProductCategoryModel>>();
  var errorMessage = RxnString();

  // Function to handle user login
  Future<void> getCategories() async {
    isLoading.value = true;
    final result = await _repo.getCategories();
    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        update();
      },
      (categories) {
        isLoading.value = false;
        categoriesList.value = categories;
        update();
      },
    );
  }
}
