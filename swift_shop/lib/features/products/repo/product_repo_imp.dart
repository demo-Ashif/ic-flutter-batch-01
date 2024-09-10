import 'package:dartz/dartz.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';
import 'package:swift_shop/features/products/domain/models/product_model.dart';
import 'package:swift_shop/features/products/domain/models/review_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/typedefs.dart';
import '../data/product_remote_data_src.dart';
import '../domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  const ProductRepoImpl(this._remoteDataSource);

  final ProductRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<ProductModel>> getProducts(int page) async {
    try {
      final result = await _remoteDataSource.getProducts(page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<ProductModel> getProduct(String productId) async {
    try {
      final result = await _remoteDataSource.getProduct(productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    required int page,
  }) async {
    try {
      final result = await _remoteDataSource.getProductsByCategory(
          categoryId: categoryId, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductModel>> getNewArrivals({
    required int page,
    String? categoryId,
  }) async {
    try {
      final result = await _remoteDataSource.getNewArrivals(
        page: page,
        categoryId: categoryId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductModel>> getPopular({
    required int page,
    String? categoryId,
  }) async {
    try {
      final result = await _remoteDataSource.getPopular(
        page: page,
        categoryId: categoryId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductModel>> searchAllProducts({
    required String query,
    required int page,
  }) async {
    try {
      final result =
      await _remoteDataSource.searchAllProducts(query: query, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductModel>> searchByCategory({
    required String query,
    required String categoryId,
    required int page,
  }) async {
    try {
      final result = await _remoteDataSource.searchByCategory(
          query: query, categoryId: categoryId, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductModel>> searchByCategoryAndGenderAgeCategory({
    required String query,
    required String categoryId,
    required String genderAgeCategory,
    required int page,
  }) async {
    try {
      final result =
      await _remoteDataSource.searchByCategoryAndGenderAgeCategory(
          query: query,
          categoryId: categoryId,
          genderAgeCategory: genderAgeCategory,
          page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductCategoryModel>> getCategories() async {
    try {
      final result = await _remoteDataSource.getCategories();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<ProductCategoryModel> getCategory(String categoryId) async {
    try {
      final result = await _remoteDataSource.getCategory(categoryId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> leaveReview({
    required String productId,
    required String userId,
    required String comment,
    required double rating,
  }) async {
    try {
      await _remoteDataSource.leaveReview(
          productId: productId,
          userId: userId,
          comment: comment,
          rating: rating);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ReviewModel>> getProductReviews({
    required String productId,
    required int page,
  }) async {
    try {
      final result = await _remoteDataSource.getProductReviews(
          productId: productId, page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}