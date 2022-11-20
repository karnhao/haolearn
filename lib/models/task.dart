import 'package:haolearn/models/priority.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 5)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  double? score;

  @HiveField(3)
  DateTime? dueDate;

  @HiveField(4)
  Priority priority = Priority.normal;

  Task(
      {this.title = "untitled",
      this.description = "",
      double? score,
      DateTime? dueDate,
      Priority priority = Priority.normal});
}
