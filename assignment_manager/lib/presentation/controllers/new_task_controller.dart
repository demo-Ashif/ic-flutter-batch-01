import 'package:get/get.dart';

import '../../data/models/response_model.dart';
import '../../data/services/api_service.dart';
import '../../data/utils/network_const.dart';

class NewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'SignUp failed! Try again';

  Future<bool> addNewTask(String title, String description) async {
    _inProgress = true;
    update();

    // api call
    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": "New"
    };

    ResponseModel response = await ApiService.postRequest(
      NetworkConst.createTask,
      inputParams,
    );

    _inProgress = false;

    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
