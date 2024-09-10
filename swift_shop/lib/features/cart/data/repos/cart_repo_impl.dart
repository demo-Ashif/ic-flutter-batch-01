import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/models/cart_product_model.dart';
import '../../domain/repos/cart_repo.dart';
import '../datasources/cart_remote_data_src.dart';

class CartRepoImpl implements CartRepo {
  const CartRepoImpl(this._remoteDataSource);

  final CartRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<CartProductModel>> getCart(String userId) async {
    try {
      final result = await _remoteDataSource.getCart(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<int> getCartCount(String userId) async {
    try {
      final result = await _remoteDataSource.getCartCount(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<CartProductModel> getCartProduct({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      final result = await _remoteDataSource.getCartProduct(
          userId: userId, cartProductId: cartProductId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> addToCart({
    required String userId,
    required CartProductModel cartProduct,
  }) async {
    try {
      await _remoteDataSource.addToCart(
          userId: userId, cartProduct: cartProduct);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> removeFromCart({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      await _remoteDataSource.removeFromCart(
          userId: userId, cartProductId: cartProductId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  }) async {
    try {
      await _remoteDataSource.changeCartProductQuantity(
          userId: userId,
          cartProductId: cartProductId,
          newQuantity: newQuantity);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
  @override
  ResultFuture<String> initiateCheckout({
    required String theme,
    required List<CartProductModel> cartItems,
  }) async {
    try {
      final result = await _remoteDataSource.initiateCheckout(
        theme: theme,
        cartItems: cartItems,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
