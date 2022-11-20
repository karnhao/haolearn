import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject_content.dart';
import 'package:haolearn/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'subject.g.dart';

@HiveType(typeId: 3)
class Subject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? room;

  @HiveField(2)
  String? teacherName;

  @HiveField(3)
  List<StudyTime> studyTimes = List.empty(growable: true);

  @HiveField(4)
  List<Task> tasks = List.empty(growable: true);

  @HiveField(5)
  List<SubjectContent> contents = List.empty(growable: true);

  Subject({required this.name});
}
