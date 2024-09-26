import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:swift_shop/features/cart/domain/repos/cart_repo.dart';

import '../../../../core/router/app_router.dart';
import '../../domain/models/cart_product_model.dart';

import 'package:get/get.dart';
import 'package:swift_shop/features/cart/domain/models/cart_product_model.dart';
import 'package:swift_shop/features/cart/domain/repos/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo _repo;

  CartController(this._repo);

  // Observables
  var cartProducts = <CartProductModel>[].obs;
  var selectedProducts = <String>[].obs;
  var isLoading = false.obs;
  var isAddingToCart = false.obs;
  var isRemovingFromCart = false.obs;
  var cartCount = 0.obs;
  var errorMessage = ''.obs;
  var fetchedProduct = Rxn<CartProductModel>();

  /// Fetch Cart Items
  /// Fetch Cart Items
  Future<void> fetchCart(String userId) async {
    try {
      isLoading.value = true;
      update(); // Notify listeners
      final result = await _repo.getCart(userId);
      result.fold(
        (failure) {
          errorMessage.value = failure.errorMessage;
        },
        (products) {
          cartProducts.assignAll(products);
        },
      );
    } finally {
      isLoading.value = false;
      update(); // Notify listeners
    }
  }

  /// Fetch a Single Cart Product
  Future<void> fetchCartProduct({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      isLoading.value = true;
      final result = await _repo.getCartProduct(
        userId: userId,
        cartProductId: cartProductId,
      );
      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          fetchedProduct.value = null; // Clear the fetched product
        },
        (product) {
          fetchedProduct.value = product;
        },
      );
    } finally {
      isLoading.value = false;
      update(); // Notify listeners
    }
  }

  /// Fetch Cart Count
  Future<void> fetchCartCount(String userId) async {
    try {
      final result = await _repo.getCartCount(userId);
      result.fold(
        (failure) => errorMessage.value = failure.errorMessage,
        (count) => cartCount.value = count,
      );
    } finally {
      update(); // Notify listeners
    }
  }

  /// Add to Cart
  Future<void> addToCart({
    required String userId,
    required CartProductModel cartProduct,
  }) async {
    try {
      isAddingToCart.value = true;
      final result =
          await _repo.addToCart(userId: userId, cartProduct: cartProduct);
      result.fold(
        (failure) => errorMessage.value = failure.errorMessage,
        (_) {
          // Successfully added to cart, update cart details
          fetchCart(userId);
          fetchCartCount(userId);
        },
      );
    } finally {
      isAddingToCart.value = false;
      update(); // Notify listeners
    }
  }

  /// Remove from Cart
  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      isRemovingFromCart.value = true;
      final result = await _repo.removeFromCart(
          userId: userId, cartProductId: cartProductId);
      result.fold(
        (failure) => errorMessage.value = failure.errorMessage,
        (_) {
          // Successfully removed from cart, update cart details
          fetchCart(userId);
          fetchCartCount(userId);
        },
      );
    } finally {
      isRemovingFromCart.value = false;
      update(); // Notify listeners
    }
  }

  /// Change Product Quantity in Cart
  Future<void> changeProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  }) async {
    try {
      isLoading.value = true;
      updatingProductId.value =
          cartProductId; // Set the product ID being updated
      final result = await _repo.changeCartProductQuantity(
        userId: userId,
        cartProductId: cartProductId,
        newQuantity: newQuantity,
      );
      result.fold(
        (failure) => errorMessage.value = failure.errorMessage,
        (_) {
          // Successfully changed quantity, update cart details
          fetchCart(userId);
        },
      );
    } finally {
      isLoading.value = false;
      updatingProductId.value = ''; // Clear the updating product ID
      update(); // Notify listeners
    }
  }

  /// Initiate Checkout
  Future<void> initiateCheckout({
    required String theme,
    required List<CartProductModel> cartItems,
  }) async {
    try {
      isLoading.value = true;
      final result = await _repo.initiateCheckout(
        theme: theme,
        cartItems: cartItems,
      );
      result.fold(
        (failure) => errorMessage.value = failure.errorMessage,
        (checkoutUrl) {
          // Navigate to the checkout URL or handle success
          // For example:
          Get.toNamed('${AppRoutes.checkoutScreen}?checkoutUrl=$checkoutUrl');
        },
      );
    } finally {
      isLoading.value = false;
      update(); // Notify listeners
    }
  }

  // Select all products
  void selectAllProducts(List<String> productIds) {
    selectedProducts.assignAll(productIds);
    update(); // Notify listeners
  }

  // Deselect all products
  void deselectAllProducts() {
    selectedProducts.clear();
    update(); // Notify listeners
  }

  // Select a single product
  void selectProduct(String productId) {
    if (!selectedProducts.contains(productId)) {
      selectedProducts.add(productId);
      update(); // Notify listeners
    }
  }

// Deselect a single product
  void deselectProduct(String productId) {
    selectedProducts.remove(productId);
    update(); // Notify listeners
  }

  var updatingProductId = ''.obs;

  // Check if a specific product is being updated
  bool isProductBeingUpdated(String productId) {
    return updatingProductId.value == productId;
  }

  bool isProductSelected(String productId) {
    return selectedProducts.contains(productId);
  }
}
