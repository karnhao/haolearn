import 'dart:math';

import 'package:haolearn/models/notification_model.dart';
import 'package:haolearn/models/priority.dart';
import 'package:haolearn/services/notification_service.dart';
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

  @HiveField(6)
  final int id = Random().nextInt(pow(2, 31).toInt() - 1);

  Task(
      {this.title = "untitled",
      this.description = "",
      this.score = 0,
      this.dueDate,
      this.priority = Priority.normal,
      this.complete = false});

  Future<void> registerNotification(
      NotificationModel notificationModel, NotificationChannel channel) async {
    await NotificationService.getService()
        .addNotification(notificationModel, channel);
  }

  Future<void> logoutNotification() async {
    await NotificationService.getService().removeNotification(id);
  }
}
