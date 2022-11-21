import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/models/subject_table.dart';
import 'package:haolearn/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'table.g.dart';

@HiveType(typeId: 2)
class Table {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Subject> subjectList = List.empty(growable: true);

  Table({required this.name});

  List<Task> getAllTask() {
    List<Task> result = List.empty(growable: true);
    for (var t in subjectList) {
      for (var u in t.tasks) {
        result.add(u);
      }
    }
    return result;
  }

  /// day คือวันในอาทิตย์
  ///
  /// 0 คือวันอาทิตย์
  /// 1 คือวันจันทร์
  /// 2 คือวันอังคาร
  /// ...
  /// 5 คือวันศุกร์
  /// 6 คือวันเสาร์
  ///
  /// throw exception เมื่อ day ไม่อยู่ในช่วง [0, 6]
  List<SubjectTable> getSubjectTableList(
      {required int day, int startTime = 0, int endTime = 1440}) {
    if (day < 0 || day > 6) throw Exception("Day is out of range!");
    List<SubjectTable> result = List.empty(growable: true);
    int temp = startTime;
    List<SubjectTable> tempSubject = List.empty(growable: true);

    for (var i in subjectList) {
      for (var j in i.studyTimes) {
        if (j.day != day) continue;
        tempSubject.add(SubjectTable(
            name: i.name,
            time: j,
            isEmptySubject: false,
            room: i.room,
            teacherName: i.teacherName));
      }
    }

    tempSubject.sort((a, b) => a.time.startTime.compareTo(b.time.startTime));

    for (SubjectTable i in tempSubject) {
      if (temp < i.time.startTime) {
        final st = StudyTime(
            day: i.time.day, startTime: temp, width: i.time.startTime - temp);
        result.add(SubjectTable(name: "", time: st));
        temp = st.getEndTime();
      } else {
        result.add(i);
        temp = i.time.getEndTime();
      }
    }

    return result;
  }
}
