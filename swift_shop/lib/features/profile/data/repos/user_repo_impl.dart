import 'package:dartz/dartz.dart';
import 'package:swift_shop/features/profile/domain/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/user_repo.dart';
import '../datasources/user_remote_data_src.dart';

class UserRepoImpl implements UserRepo {
  const UserRepoImpl(this._remoteDataSource);

  final UserRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<UserModel> getUser(String userId) async {
    try {
      final result = await _remoteDataSource.getUser(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final result = await _remoteDataSource.updateUser(
        userId: userId,
        updateData: updateData,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
