import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/kappbar.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String subjectName = "Subject";
  //dynamic date = "Deadline date";
  bool toggle = false;
  final service = StorageService.getService();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createKAppBar(context, "$subjectName task"),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: appBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            enabled: toggle,
                            decoration: InputDecoration(hintText: 'Task'),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                      IconButton(
                          onPressed: toggle
                              ? () {
                                  _selectDate(context).then((v) {
                                    selectedDate = v ?? DateTime.now();
                                    setState(() {});
                                  });
                                }
                              : null,
                          icon: Icon(Icons.edit))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: toggle,
                            decoration: InputDecoration(
                                hintText: 'Score',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5)),
                          ),
                        ),
                        Text("/"),
                        Expanded(
                            child: TextField(
                          decoration: InputDecoration(
                              hintText: "Full score",
                              enabled: toggle,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5)),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 10,
              bottom: 10,
              child: InkWell(
                  onTap: () {},
                  child: Switch(
                    value: toggle,
                    onChanged: (value) {
                      setState(
                        () {
                          toggle = value;
                        },
                      );
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.lightGreenAccent,
                  )))
        ]));
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2050, 12, 31),
        onChanged: (date) {},
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.th);
  }
}
