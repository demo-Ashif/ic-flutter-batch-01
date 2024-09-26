import 'package:get/get.dart';
import 'package:swift_shop/features/profile/domain/models/user_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/user_repo.dart';

class ProfileController extends GetxController {
  final UserRepo _repo;

  ProfileController(this._repo);

  var user = const UserModel(
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '1234567890',
    id: '',
    isAdmin: false,
    wishlist: [],
  ).obs;
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var errorMessage = ''.obs;

  /// Fetch user data
  Future<void> fetchUser(String userId) async {
    isLoading.value = true;
    final result = await _repo.getUser(userId);
    result.fold((failure) {
      errorMessage.value = _mapFailureToMessage(failure);
    }, (userData) {
      user.value = userData;
    });
    isLoading.value = false;

    update();
  }

  /// Update user data
  Future<void> updateUser(String userId, DataMap updateData) async {
    isUpdating.value = true;
    final result =
        await _repo.updateUser(userId: userId, updateData: updateData);
    result.fold((failure) {
      errorMessage.value = _mapFailureToMessage(failure);
    }, (updatedUser) {
      user.value = updatedUser;
      Get.snackbar('Success', 'Profile updated successfully');
    });
    isUpdating.value = false;
  }

  /// Helper method to map Failure to error messages
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      default:
        return 'An unexpected error occurred';
    }
  }
}
