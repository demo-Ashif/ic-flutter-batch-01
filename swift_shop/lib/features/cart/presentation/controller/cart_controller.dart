import 'package:get/get.dart';
import 'package:swift_shop/features/cart/domain/repos/cart_repo.dart';

import '../../domain/models/cart_product_model.dart';

class CartController extends GetxController {
  final CartRepo _repo;

  CartController(this._repo);

  var cartProducts = <CartProductModel>[].obs; // Cart items
  var isLoading = false.obs; // Loading state
  var errorMessage = ''.obs; // Error state

  //add to cart
  Future<void> addToCart({
    required String userId,
    required CartProductModel cartProductModel,
  }) async {
    isLoading(true);
    errorMessage('');

    final result = await _repo.addToCart(
      cartProduct: cartProductModel,
      userId: userId,
    );

    result.fold(
      (failure) => errorMessage(failure.message), // Handle error case
      (cartProducts) =>
          getCartProducts(userId), // Assign result to observable list
    );
    isLoading(false);
  }

  //get cart product list
  Future<void> getCartProducts(String userId) async {
    isLoading(true);
    errorMessage('');

    final result = await _repo.getCart(
      userId,
    );

    result.fold(
      (failure) => errorMessage(failure.message), // Handle error case
      (cartProductList) => cartProducts
          .assignAll(cartProductList), // Assign result to observable list
    );
    isLoading(false);
    update();
  }

//remove from cart

//update quantity
}
