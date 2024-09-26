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

// Remove from cart
  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  }) async {
    isLoading(true);
    errorMessage('');

    final result = await _repo.removeFromCart(
      userId: userId,
      cartProductId: cartProductId,
    );

    result.fold(
          (failure) => errorMessage(failure.message), // Handle error case
          (success) => getCartProducts(userId), // Refresh cart
    );
    isLoading(false);
    update();
  }

  // Update quantity of a cart product
  Future<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  }) async {
    isLoading(true);
    errorMessage('');

    final result = await _repo.changeCartProductQuantity(
      userId: userId,
      cartProductId: cartProductId,
      newQuantity: newQuantity,
    );

    result.fold(
          (failure) => errorMessage(failure.message), // Handle error case
          (success) => getCartProducts(userId), // Refresh cart
    );
    isLoading(false);
    update();
  }

  // Get cart product count
  Future<int> getCartCount(String userId) async {
    isLoading(true);
    errorMessage('');

    final result = await _repo.getCartCount(userId);

    int count = 0;
    result.fold(
          (failure) => errorMessage(failure.message), // Handle error case
          (cartCount) => count = cartCount, // Update count
    );
    isLoading(false);
    return count;
  }

  // Get individual cart product
  Future<CartProductModel?> getCartProduct({
    required String userId,
    required String cartProductId,
  }) async {
    isLoading(true);
    errorMessage('');

    CartProductModel? product;

    final result = await _repo.getCartProduct(
      userId: userId,
      cartProductId: cartProductId,
    );

    result.fold(
          (failure) => errorMessage(failure.message), // Handle error case
          (cartProduct) => product = cartProduct, // Return cart product
    );
    isLoading(false);
    return product;
  }
}
