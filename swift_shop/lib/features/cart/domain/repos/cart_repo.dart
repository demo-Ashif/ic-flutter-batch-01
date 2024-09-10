
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';

import '../../../../core/utils/typedefs.dart';

abstract class CartRepo {
  ResultFuture<List<CartProductModel>> getCart(String userId);

  ResultFuture<int> getCartCount(String userId);

  ResultFuture<CartProductModel> getCartProduct({
    required String userId,
    required String cartProductId,
  });

  ResultFuture<void> addToCart({
    required String userId,
    required CartProductModel cartProduct,
  });

  ResultFuture<void> removeFromCart({
    required String userId,
    required String cartProductId,
  });

  ResultFuture<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  });
  ResultFuture<String> initiateCheckout({
    required String theme,
    required List<CartProductModel> cartItems,
  });
}

