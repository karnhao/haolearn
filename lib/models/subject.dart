import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject_content.dart';
import 'package:haolearn/models/subject_score.dart';
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

  @HiveField(5)
  List<SubjectScore> scores = List.empty(growable: true);

  Subject({required this.name});

  void addContent(
      {String title = "Untitled",
      String description = "",
      ContentUnderstanding understanding = ContentUnderstanding.normal}) {
    contents.add(SubjectContent(
        title: title, description: description, understanding: understanding));
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

  double getSigmaScore() {
    return _sigma(scores.map((t) => t.score));
  }

  double getMaxSigmaScore() {
    return _sigma(scores.map((t) => t.maxScore));
  }

  double _sigma(Iterable<double> lists, {initialValue = 0.0}) {
    return lists.fold(
        initialValue, (previousValue, element) => previousValue + element);
  }

  void sortContentViaUnderstanding({bool reverse = false}) {
    contents
        .sort((a, b) => a.understanding.level.compareTo(b.understanding.level));
    if (reverse) {
      contents = contents.reversed.toList();
    }
  }
}
