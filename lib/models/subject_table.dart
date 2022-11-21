import 'package:haolearn/models/study_time.dart';

class SubjectTable {
  late String name;
  late StudyTime time;
  String? room;
  String? teacherName;
  bool isEmptySubject;

  SubjectTable(
      {required this.name,
      required this.time,
      this.room,
      this.teacherName,
      this.isEmptySubject = false});
}
