import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject_content.dart';
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
  List<SubjectContent> contents = List.empty(growable: true);

  Subject({required this.name});

  void addContent({String title = "Untitled", String description = ""}) {
    contents.add(SubjectContent(title: title, description: description));
  }

  void removeContent(int index) {
    contents.removeAt(index);
  }

  void swapContent(int index1, int index2) {
    if (contents.length <= index1 || contents.length <= index2) {
      throw Exception("Index out of bounds : $index1 or $index2");
    }
    final temp = contents[index1];
    contents[index1] = contents[index2];
    contents[index2] = temp;
  }

  void addTime(StudyTime time) {
    studyTimes.add(time);
  }

  void setRoom(String room) {
    this.room = room;
  }
}
