import 'package:swift_shop/features/products/domain/models/product_category.dart';
import 'package:swift_shop/features/products/domain/models/product_model.dart';
import 'package:swift_shop/features/products/domain/models/review_model.dart';

import '../../../../core/utils/typedefs.dart';

abstract class ProductRepo {
  ResultFuture<List<ProductModel>> getProducts(int page);
  ResultFuture<ProductModel> getProduct(String productId);
  ResultFuture<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    required int page,
  });
  ResultFuture<List<ProductModel>> getNewArrivals({
    required int page,
    String? categoryId,
  });
  ResultFuture<List<ProductModel>> getPopular({
    required int page,
    String? categoryId,
  });
  ResultFuture<List<ProductModel>> searchAllProducts({
    required String query,
    required int page,
  });
  ResultFuture<List<ProductModel>> searchByCategory({
    required String query,
    required String categoryId,
    required int page,
  });
  ResultFuture<List<ProductModel>> searchByCategoryAndGenderAgeCategory({
    required String query,
    required String categoryId,
    required String genderAgeCategory,
    required int page,
  });
  ResultFuture<List<ProductCategoryModel>> getCategories();
  ResultFuture<ProductCategoryModel> getCategory(String categoryId);
  ResultFuture<void> leaveReview({
    required String productId,
    required String userId,
    required String comment,
    required double rating,
  });
  ResultFuture<List<ReviewModel>> getProductReviews({
    required String productId,
    required int page,
  });
}