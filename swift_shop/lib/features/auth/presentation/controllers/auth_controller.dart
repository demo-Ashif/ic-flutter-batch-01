import 'package:get/get.dart';
import 'package:swift_shop/core/router/app_router.dart';
import 'package:swift_shop/features/auth/presentation/screens/login_screen.dart';
import 'package:swift_shop/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:swift_shop/features/home/presentation/screens/home_screen.dart';

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../../profile/domain/models/user_model.dart';
import '../../domain/repos/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo;

  AuthController(this._authRepo);

  // Observables for managing state
  var isLoading = false.obs;
  var isTokenValid = false.obs;
  var user = Rxn<UserModel>();
  var errorMessage = RxnString();

  // Function to handle user registration
  Future<void> register({
    required String name,
    required String password,
    required String email,
    required String phone,
  }) async {
    isLoading.value = true; // Set loading to true
    final result = await _authRepo.register(
      name: name,
      password: password,
      email: email,
      phone: phone,
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        Get.snackbar('Error', failure.message);
        isLoading.value = false; // Set loading to false on failure
      },
      (_) {
        Get.snackbar('Success', 'Registration successful');
        isLoading.value = false; // Set loading to false on success
        Get.offAll(
            () => const LoginScreen()); // Navigate to the relevant screen
      },
    );
  }

  // Function to handle user login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    final result = await _authRepo.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      (userModel) {
        user.value = userModel;
        Get.snackbar('Success', 'Login successful');
        isLoading.value = false;
        Get.to(() => const DashboardScreen());
      },
    );
  }

  Future<void> tokenVerify() async {
    final result = await _authRepo.verifyToken();
    result.fold(
      (failure) async{
        await sl<CacheHelper>().resetSession();
        isTokenValid.value = false;
        errorMessage.value = failure.message;
      },
      (isValid) async {
        isTokenValid.value = true;
        if (!isValid) {
          await sl<CacheHelper>().resetSession();
        }
      },
    );
  }
}
