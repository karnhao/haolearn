import 'package:flutter/material.dart';
import 'package:haolearn/models/subject_table.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:time_planner/time_planner.dart';

Widget createTableWidget(BuildContext context) {
  final mainTable = StorageService.getService().getSaveData()!.getMainTable()!;
  List<SubjectTable> allSubjectTables = List.empty(growable: true);
  List<Color> dayColor = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.purple
  ];
  for (var t in [0, 1, 2, 3, 4, 5, 6]) {
    allSubjectTables.addAll(mainTable.getSubjectTableList(day: t));
  }
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber[100],
      child: Center(
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
            cellWidth: 200,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          tasks: allSubjectTables
              .where((u) => !u.isEmptySubject)
              .map((t) => TimePlannerTask(
                    color: dayColor[t.time.day],
                    dateTime: TimePlannerDateTime(
                        day: t.time.day,
                        hour: t.time.getStartHour(),
                        minutes: t.time.getStartMinute()),
                    minutesDuration: t.time.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t.name,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          t.room ?? "",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          t.time.getTimeName(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ));
}
