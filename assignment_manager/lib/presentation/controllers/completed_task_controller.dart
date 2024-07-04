import 'package:assignment_manager/data/models/task_item.dart';
import 'package:assignment_manager/data/models/task_list_response.dart';
import 'package:get/get.dart';

import '../../data/models/response_model.dart';
import '../../data/services/api_service.dart';
import '../../data/utils/network_const.dart';

class CompletedTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'SignUp failed! Try again';

  List<TaskItem> _completedTasks = [];

  List<TaskItem> get completedTasks => _completedTasks;

  @override
  void onInit() {
    super.onInit();

    getTaskByStatus('completed');
  }

  Future<bool> getTaskByStatus(String status) async {
    _inProgress = true;
    update();

    ResponseModel response = await ApiService.getRequest(
      '${NetworkConst.getTaskByStatus}/$status',
    );

    _completedTasks =
        TaskListModelResponse.fromJson(response.responseBody).data;

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
