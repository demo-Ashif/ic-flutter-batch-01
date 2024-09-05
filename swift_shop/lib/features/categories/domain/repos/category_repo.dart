import 'package:swift_shop/features/products/domain/product_category.dart';

import '../../../../core/utils/typedefs.dart';

abstract class CategoryRepo {
  ResultFuture<List<ProductCategoryModel>> getCategories();
}
