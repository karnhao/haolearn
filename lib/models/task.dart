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
  double score;

  @HiveField(3)
  DateTime? dueDate;

  @HiveField(4)
  Priority priority = Priority.normal;

  @HiveField(5)
  bool complete = false;

  Task(
      {this.title = "untitled",
      this.description = "",
      this.score = 0,
      this.dueDate,
      this.priority = Priority.normal,
      this.complete = false});
}
