import 'package:flutter/material.dart';
import 'package:haolearn/models/subject_table.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:time_planner/time_planner.dart';

Widget createTableWidget(BuildContext context) {
  final mainTable = StorageService.getService().getSaveData()!.getMainTable()!;
  List<SubjectTable> allSubjectTables = List.empty(growable: true);
  for (var t in [0, 1, 2, 3, 4, 5, 6]) {
    allSubjectTables.addAll(mainTable.getSubjectTableList(day: t));
  }
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber[100],
      child: TimePlanner(
        currentTimeAnimation: true,
        startHour: 6,
        endHour: 21,
        headers: const [
          TimePlannerTitle(title: "SUN"),
          TimePlannerTitle(title: "MON"),
          TimePlannerTitle(title: "TUE"),
          TimePlannerTitle(title: "WED"),
          TimePlannerTitle(title: "TRU"),
          TimePlannerTitle(title: "FRI"),
          TimePlannerTitle(title: "SAT"),
        ],
        style: TimePlannerStyle(
          backgroundColor: const Color.fromARGB(255, 253, 119, 164),
        ),
        tasks: allSubjectTables
            .where((u) => !u.isEmptySubject)
            .map((t) => TimePlannerTask(
                  dateTime: TimePlannerDateTime(
                      day: t.time.day,
                      hour: t.time.getStartHour(),
                      minutes: t.time.getStartMinute()),
                  minutesDuration: t.time.width,
                ))
            .toList(),
      ));
}
