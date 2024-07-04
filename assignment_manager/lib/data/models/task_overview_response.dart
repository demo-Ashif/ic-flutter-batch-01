import 'dart:convert';

import 'task_overview.dart';

TaskOverviewResponse taskOverviewResponseFromJson(String str) => TaskOverviewResponse.fromJson(json.decode(str));

String taskOverviewResponseToJson(TaskOverviewResponse data) => json.encode(data.toJson());

class TaskOverviewResponse {
  bool success;
  List<TaskOverview> data;

  TaskOverviewResponse({
    required this.success,
    required this.data,
  });

  TaskOverviewResponse copyWith({
    bool? success,
    List<TaskOverview>? data,
  }) =>
      TaskOverviewResponse(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory TaskOverviewResponse.fromJson(Map<String, dynamic> json) => TaskOverviewResponse(
    success: json["success"],
    data: List<TaskOverview>.from(json["data"].map((x) => TaskOverview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
