import 'package:get/get.dart';

import '../../domain/models/product_model.dart';
import '../../domain/repo/product_repo.dart';

class ProductController extends GetxController {
  final ProductRepo _productRepo;

  ProductController(this._productRepo);

  // Observables for different API responses
  var products = <ProductModel>[].obs;
  var newArrivals = <ProductModel>[].obs;
  var popularProducts = <ProductModel>[].obs;

  var productDetail = const ProductModel.empty().obs;

  // Loading states for the different API calls
  var isLoadingProducts = false.obs;
  var isLoadingProductDetail = false.obs;
  var isLoadingNewArrivals = false.obs;
  var isLoadingPopular = false.obs;

  // Error messages for the different API calls
  var productsError = ''.obs;
  var newArrivalsError = ''.obs;
  var popularError = ''.obs;

  // Fetch products
  Future<void> fetchProducts(int page) async {
    isLoadingProducts(true);
    productsError('');
    final result = await _productRepo.getProducts(page);

    result.fold(
      (failure) => productsError(failure.message), // Handle error case
      (productList) =>
          products.assignAll(productList), // Assign result to observable list
    );
    isLoadingProducts(false);
  }

  // Fetch new arrivals
  Future<void> fetchNewArrivals(int page, {String? categoryId}) async {
    isLoadingNewArrivals(true);
    newArrivalsError('');
    final result =
        await _productRepo.getNewArrivals(page: page, categoryId: categoryId);

    result.fold(
      (failure) => newArrivalsError(failure.message), // Handle error case
      (newArrivalList) => newArrivals
          .assignAll(newArrivalList), // Assign result to observable list
    );
    isLoadingNewArrivals(false);
  }

  // Fetch popular products
  Future<void> fetchPopularProducts(int page, {String? categoryId}) async {
    isLoadingPopular(true);
    popularError('');
    final result =
        await _productRepo.getPopular(page: page, categoryId: categoryId);

    result.fold(
      (failure) => popularError(failure.message), // Handle error case
      (popularList) => popularProducts
          .assignAll(popularList), // Assign result to observable list
    );
    isLoadingPopular(false);
    update();
  }

  // Fetch popular products
  Future<void> fetchProductById(String productId) async {
    isLoadingProductDetail(true);
    productsError('');
    final result = await _productRepo.getProduct(productId);

    result.fold(
      (failure) => productsError(failure.message), // Handle error case
      (product) =>
          productDetail.value = product, // Assign result to observable list
    );
    isLoadingProductDetail(false);
    update();
  }
}
