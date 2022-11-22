import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/models/subject_table.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'table.g.dart';

@HiveType(typeId: 2)
class Table {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Subject> subjectList = List.empty(growable: true);

  Table({required this.name});

  /// day คือวันในอาทิตย์
  ///
  /// 0 คือวันอาทิตย์
  /// 1 คือวันจันทร์
  /// 2 คือวันอังคาร
  /// ...
  /// 5 คือวันศุกร์
  /// 6 คือวันเสาร์
  ///
  /// KU: startTime: 480, endTime: 1260
  ///
  /// throw exception เมื่อ day ไม่อยู่ในช่วง [0, 6]
  List<SubjectTable> getSubjectTableList(
      {required int day, int startTime = 0, int endTime = 1439}) {
    if (day < 0 || day > 6) throw Exception("Day is out of range!");
    List<SubjectTable> result = List.empty(growable: true);
    int temp = startTime;
    List<SubjectTable> tempSubject = List.empty(growable: true);

    for (var i in subjectList) {
      for (var j in i.studyTimes) {
        if (j.day != day) continue;
        tempSubject.add(SubjectTable(
            name: i.name,
            time: StudyTime(day: j.day, startTime: j.startTime, width: j.width),
            isEmptySubject: false,
            room: i.room,
            teacherName: i.teacherName));
      }
    }

    tempSubject.sort((a, b) => a.time.startTime.compareTo(b.time.startTime));

    for (int i = 0; i < tempSubject.length;) {
      if (temp < tempSubject[i].time.startTime) {
        final st = StudyTime(
            day: tempSubject[i].time.day,
            startTime: temp,
            width: tempSubject[i].time.startTime - temp);
        result.add(SubjectTable(name: "", time: st));
        temp = st.getEndTime();
      } else {
        if (tempSubject[i].time.startTime < startTime) {
          tempSubject[i].time.width -=
              startTime - tempSubject[i].time.startTime;
          tempSubject[i].time.startTime = startTime;
        }
        if (tempSubject[i].time.getEndTime() > endTime) {
          tempSubject[i].time.width -=
              tempSubject[i].time.getEndTime() - endTime;
        }
        result.add(tempSubject[i]);
        temp = tempSubject[i].time.getEndTime();
        i++;
      }
    }

    if (temp < endTime) {
      result.add(SubjectTable(
          name: "",
          isEmptySubject: true,
          time: StudyTime(day: day, startTime: temp, width: endTime - temp)));
    }

    return result;
  }
}
