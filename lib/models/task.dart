import 'package:haolearn/models/priority.dart';

class Task {
  late String title;
  late String description;
  double? score;
  DateTime? dueDate;
  Priority priority = Priority.normal;
}
