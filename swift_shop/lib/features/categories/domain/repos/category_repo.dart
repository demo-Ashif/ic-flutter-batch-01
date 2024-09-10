import 'package:swift_shop/features/products/domain/models/product_category.dart';

import '../../../../core/utils/typedefs.dart';

abstract class CategoryRepo {
  ResultFuture<List<ProductCategoryModel>> getCategories();
}
