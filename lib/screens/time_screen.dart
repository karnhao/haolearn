import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/time_set_widget.dart';
import 'package:marquee/marquee.dart';

class TimeScreen extends StatefulWidget {
  final int index;
  const TimeScreen({super.key, required this.index});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final studyTime = data.mainTable.subjectList[widget.index].studyTimes;

    return Scaffold(
      appBar: createKAppBar(context, "Schedule"),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: kuSecColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 116,
                              maxHeight: 30),
                          child: Marquee(
                            blankSpace: 100,
                            text: data.mainTable.subjectList[widget.index].name,
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: (() {
                                setState(() {
                                  studyTime.add(StudyTime(
                                      day: 0, startTime: 0, width: 90));
                                  service.saveData();
                                });
                              }),
                              icon: const Icon(
                                Icons.add,
                                size: 40,
                              ))
                        ])
                      ]),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  height: 5,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.mainTable.subjectList[widget.index]
                          .studyTimes.length,
                      itemBuilder: ((context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Confirm delete?'),
                                        content: const Text(
                                            'This will gone forever.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => {
                                              studyTime.removeAt(index),
                                              setState(() {}),
                                              Navigator.pop(context, 'OK'),
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  label: "Delete",
                                  icon: Icons.delete,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.red,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            TimeSetWidget(
                                              index: index,
                                              subjectIndex: widget.index,
                                              onTimeSeledted:
                                                  (day, startday, widthday) {
                                                service.saveData().then(
                                                  (value) {
                                                    setState(() {});
                                                  },
                                                );
                                              },
                                            ));
                                  },
                                  label: "Edit",
                                  icon: Icons.edit,
                                  backgroundColor: Colors.transparent,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 22),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.9),
                                      spreadRadius: 0.1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: kuPriColor,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 30),
                                child: Text(
                                    "${studyTime[index].getDayName()} ${studyTime[index].getTimeName()}",
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                            ),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
