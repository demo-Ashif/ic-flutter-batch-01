import 'package:assignment_manager/data/models/task_item.dart';
import 'package:assignment_manager/data/models/task_list_response.dart';
import 'package:assignment_manager/data/models/task_overview.dart';
import 'package:assignment_manager/data/models/task_overview_response.dart';
import 'package:get/get.dart';

import '../../data/models/response_model.dart';
import '../../data/services/api_service.dart';
import '../../data/utils/network_const.dart';

class OverviewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'SignUp failed! Try again';

  List<TaskOverview> _taskOverviewList = [];

  List<TaskOverview> get taskOverviewList => _taskOverviewList;

  @override
  void onInit() {
    super.onInit();

    getTaskOverview();
  }

  Future<bool> getTaskOverview() async {
    _inProgress = true;
    update();

    ResponseModel response = await ApiService.getRequest(
      NetworkConst.getTaskOverview,
    );

    _taskOverviewList =
        TaskOverviewResponse.fromJson(response.responseBody).data;

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
