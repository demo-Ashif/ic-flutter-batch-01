import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';

import 'package:swift_shop/features/wishlist/domain/models/wishlist_product_model.dart';
import '../../domain/repos/wishlist_repo.dart';

class WishlistController extends GetxController {
  final WishlistRepo _repo;

  WishlistController(this._repo);

  var wishlist = <WishlistProductModel>[].obs;   // Changed to WishlistProductModel
  var isLoading = false.obs;                     // Loading state
  var isAdding = false.obs;                      // Adding to wishlist state
  var isRemoving = false.obs;                    // Removing from wishlist state
  var errorMessage = ''.obs;                     // To store error messages

  /// Fetch Wishlist
  Future<void> fetchWishlist(String userId) async {
    try {
      isLoading.value = true;
      final result = await _repo.getWishlist(userId);
      result.fold(
            (failure) {
          errorMessage.value = _mapFailureToMessage(failure);
        },
            (fetchedWishlist) {
          wishlist.value = fetchedWishlist;
        },
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  /// Add to Wishlist
  Future<void> addToWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      isAdding.value = true;
      final result = await _repo.addToWishlist(userId: userId, productId: productId);
      result.fold(
            (failure) {
          errorMessage.value = _mapFailureToMessage(failure);
        },
            (_) {
          Get.snackbar('Success', 'Product added to wishlist');
          fetchWishlist(userId); // Refresh the wishlist after adding
        },
      );
    } finally {
      isAdding.value = false;
      update();
    }
  }

  /// Remove from Wishlist
  Future<void> removeFromWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
      isRemoving.value = true;
      final result = await _repo.removeFromWishlist(userId: userId, productId: productId);
      result.fold(
            (failure) {
          errorMessage.value = _mapFailureToMessage(failure);
        },
            (_) {
          Get.snackbar('Success', 'Product removed from wishlist');
          fetchWishlist(userId); // Refresh the wishlist after removal
        },
      );
    } finally {
      isRemoving.value = false;
      update();
    }
  }

  /// Helper method to map Failure to error messages
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred: ${failure.message}';
      default:
        return 'An unexpected error occurred';
    }
  }
}

