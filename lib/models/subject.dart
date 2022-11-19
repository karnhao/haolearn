import 'package:haolearn/models/study_time.dart';

class Subject {
  String name;
  String? room;
  String? teacherName;
  List<StudyTime> studyTimes = List.empty();

  Subject({required this.name});
}
