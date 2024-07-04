class TaskOverview {
  String status;
  int total;

  TaskOverview({
    required this.status,
    required this.total,
  });

  TaskOverview copyWith({
    String? status,
    int? total,
  }) =>
      TaskOverview(
        status: status ?? this.status,
        total: total ?? this.total,
      );

  factory TaskOverview.fromJson(Map<String, dynamic> json) => TaskOverview(
    status: json["status"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
  };
}