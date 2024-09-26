import 'package:get/get.dart';

import '../../domain/models/product_model.dart';
import '../../domain/repo/product_repo.dart';

import 'package:swift_shop/features/products/domain/models/product_category.dart';
import 'package:swift_shop/features/products/domain/models/review_model.dart';

class ProductController extends GetxController {
  final ProductRepo _repo;

  ProductController(this._repo);

  // Observables
  var isLoading = false.obs;
  var isSearching = false.obs;
  var isReviewing = false.obs;
  var products = <ProductModel>[].obs;
  var categories = <ProductCategoryModel>[].obs;
  var reviews = <ReviewModel>[].obs;
  var selectedProduct = Rxn<ProductModel>();
  var selectedCategory = Rxn<ProductCategoryModel>();
  var errorMessage = ''.obs;

  /// Fetch all categories
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final result = await _repo.getCategories();
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedCategories) => categories.value = fetchedCategories,
      );
    } finally {
      isLoading.value = false;
      update(); // Notify listeners
    }
  }

  /// Fetch a specific category by ID
  Future<void> fetchCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final result = await _repo.getCategory(categoryId);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (category) => selectedCategory.value = category,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Fetch new arrivals
  Future<void> fetchNewArrivals({required int page, String? categoryId}) async {
    try {
      isLoading.value = true;
      final result = await _repo.getNewArrivals(page: page, categoryId: categoryId);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Fetch popular products
  Future<void> fetchPopular({required int page, String? categoryId}) async {
    try {
      isLoading.value = true;
      final result = await _repo.getPopular(page: page, categoryId: categoryId);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Fetch product by ID
  Future<void> fetchProduct(String productId) async {
    try {
      isLoading.value = true;
      final result = await _repo.getProduct(productId);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (product) => selectedProduct.value = product,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Fetch reviews for a product
  Future<void> fetchProductReviews({required String productId, required int page}) async {
    try {
      isLoading.value = true;
      final result = await _repo.getProductReviews(productId: productId, page: page);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedReviews) => reviews.value = fetchedReviews,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Fetch all products
  Future<void> fetchProducts(int page) async {
    try {
      isLoading.value = true;
      final result = await _repo.getProducts(page);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Fetch products by category
  Future<void> fetchProductsByCategory({required String categoryId, required int page}) async {
    try {
      isLoading.value = true;
      final result = await _repo.getProductsByCategory(categoryId: categoryId, page: page);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Leave a review for a product
  Future<void> leaveReview({
    required String productId,
    required String userId,
    required String comment,
    required double rating,
  }) async {
    try {
      isReviewing.value = true;
      final result = await _repo.leaveReview(
          productId: productId,
          userId: userId,
          comment: comment,
          rating: rating
      );
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (_) => Get.snackbar('Success', 'Review added successfully'),
      );
    } finally {
      isReviewing.value = false;
      update();
    }
  }

  /// Search all products
  Future<void> searchAllProducts({required String query, required int page}) async {
    try {
      isSearching.value = true;
      final result = await _repo.searchAllProducts(query: query, page: page);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isSearching.value = false;
      update();
    }
  }

  /// Search products by category
  Future<void> searchByCategory({required String query, required String categoryId, required int page}) async {
    try {
      isSearching.value = true;
      final result = await _repo.searchByCategory(query: query, categoryId: categoryId, page: page);
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isSearching.value = false;
      update();
    }
  }

  /// Search products by category and gender/age category
  Future<void> searchByCategoryAndGenderAgeCategory({
    required String query,
    required String categoryId,
    required String genderAgeCategory,
    required int page,
  }) async {
    try {
      isSearching.value = true;
      final result = await _repo.searchByCategoryAndGenderAgeCategory(
          query: query,
          categoryId: categoryId,
          genderAgeCategory: genderAgeCategory,
          page: page
      );
      result.fold(
            (failure) => errorMessage.value = failure.errorMessage,
            (fetchedProducts) => products.value = fetchedProducts,
      );
    } finally {
      isSearching.value = false;
      update();
    }
  }
}

