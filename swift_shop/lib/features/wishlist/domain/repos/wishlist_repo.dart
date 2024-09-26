import 'package:swift_shop/features/wishlist/domain/models/wishlist_product_model.dart';

import '../../../../core/utils/typedefs.dart';

abstract class WishlistRepo {
  ResultFuture<List<WishlistProductModel>> getWishlist(String userId);
  ResultFuture<void> addToWishlist({
    required String userId,
    required String productId,
  });
  ResultFuture<void> removeFromWishlist({
    required String userId,
    required String productId,
  });
}
