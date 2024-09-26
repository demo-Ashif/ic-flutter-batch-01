import 'package:dartz/dartz.dart';
import 'package:swift_shop/features/wishlist/domain/models/wishlist_product_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/wishlist_repo.dart';
import '../datasources/wishlist_remote_data_src.dart';

class WishlistRepoImpl implements WishlistRepo {
  const WishlistRepoImpl(this._remoteDataSource);

  final WishlistRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<WishlistProductModel>> getWishlist(String userId) async {
    try {
      final result = await _remoteDataSource.getWishlist(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> addToWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      await _remoteDataSource.addToWishlist(
          userId: userId, productId: productId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> removeFromWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      await _remoteDataSource.removeFromWishlist(
          userId: userId, productId: productId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
