import 'package:assignment_manager/data/models/login_response_model.dart';
import 'package:assignment_manager/data/models/response_model.dart';
import 'package:assignment_manager/data/services/api_service.dart';
import 'package:assignment_manager/data/utils/network_const.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Login failed! Try again';

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      'email': email,
      'password': password,
    };

    final ResponseModel response = await ApiService.postRequest(
        NetworkConst.login, inputParams,
        fromSignIn: true);

    _inProgress = false;

    if (response.isSuccess) {
      LoginResponseModel loginResponse =
      LoginResponseModel.fromJson(response.responseBody);

      /// Save the data to local cache
      // await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.accessToken);

      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}