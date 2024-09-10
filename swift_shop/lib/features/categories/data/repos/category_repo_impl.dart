import 'package:dartz/dartz.dart';
import 'package:swift_shop/features/products/domain/models/product_category.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/category_repo.dart';
import '../datasources/category_remote_data_src.dart';

class CategoryRepoImpl implements CategoryRepo {
  const CategoryRepoImpl(this._remoteDataSource);

  final CategoryRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<ProductCategoryModel>> getCategories() async {
    try {
      final result = await _remoteDataSource.getCategories();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
