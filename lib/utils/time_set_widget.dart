import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/utils/utils.dart';

class TimeSetWidget extends StatefulWidget {
  final int index;
  final int subjectIndex;
  final Function(int day, int startday, int widthday) onTimeSeledted;
  const TimeSetWidget(
      {super.key,
      required this.index,
      required this.subjectIndex,
      required this.onTimeSeledted});

  @override
  State<TimeSetWidget> createState() => _TimeSetWidgetState();
}

class _TimeSetWidgetState extends State<TimeSetWidget> {
  bool update = true;
  late int selectedStartTime;
  late int selectedEndTime;
  late int selectedDay;
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final time = data
        .mainTable.subjectList[widget.subjectIndex].studyTimes[widget.index];
    if (update) {
      selectedStartTime = time.startTime;
      selectedEndTime = time.startTime + time.width;
      selectedDay = time.getDay();
      update = false;
    }

    const List<Set<dynamic>> list = [
      {'Sunday', 0},
      {'Monday', 1},
      {'Tuesday', 2},
      {'Wednesday', 3},
      {'Thursday', 4},
      {'Friday', 5},
      {'Saturday', 6},
    ];
    final dayName = time.getDayName();

    return AlertDialog(
      title: const Text("Edit"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
              value: selectedDay.toString(),
              hint: Text(dayName),
              items: list.map((t) {
                return DropdownMenuItem<String>(
                  value: t.last.toString(),
                  child: Text(t.first),
                );
              }).toList(),
              onChanged: (value) {
                selectedDay = int.parse(value as String);
                setState(() {});
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Start time : ${minuteToTime(selectedStartTime)}"),
              IconButton(
                  onPressed: () {
                    _selectTime(context).then((value) {
                      selectedStartTime = value!.hour * 60 + value.minute;
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("End time : ${minuteToTime(selectedEndTime)}"),
              IconButton(
                  onPressed: () {
                    _selectTime(context).then((value) {
                      selectedEndTime = value!.hour * 60 + value.minute;
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              time.day = selectedDay;
              time.startTime = selectedStartTime;
              time.width = selectedEndTime - selectedStartTime;
              widget.onTimeSeledted(time.day, time.startTime, time.width);
              Navigator.pop(context);
            },
            child: const Text("Confirm"))
      ],
    );
  }

  Future<DateTime?> _selectTime(BuildContext context) async {
    return await DatePicker.showTimePicker(context,
        showTitleActions: true,
        onChanged: (date) {},
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.th);
  }
}
