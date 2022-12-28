// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  final String id;
  final String taskName;
  final String taskDetail;
  final String date;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDetail,
    required this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        taskName: json["task_name"],
        taskDetail: json["task_detail"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_name": taskName,
        "task_detail": taskDetail,
        "date": date,
      };
}
