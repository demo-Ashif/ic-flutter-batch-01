import 'dart:convert';

import 'package:assignment_manager/data/models/task_item.dart';


TaskListModelResponse taskListModelResponseFromJson(String str) =>
    TaskListModelResponse.fromJson(json.decode(str));

String taskListModelResponseToJson(TaskListModelResponse data) =>
    json.encode(data.toJson());

class TaskListModelResponse {
  bool success;
  List<TaskItem> data;

  TaskListModelResponse({
    required this.success,
    required this.data,
  });

  TaskListModelResponse copyWith({
    bool? success,
    List<TaskItem>? data,
  }) =>
      TaskListModelResponse(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory TaskListModelResponse.fromJson(Map<String, dynamic> json) =>
      TaskListModelResponse(
        success: json["success"],
        data: List<TaskItem>.from(json["data"].map((x) => TaskItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
