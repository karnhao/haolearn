import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/screens/subject_screen.dart';
import 'package:haolearn/screens/time_detail_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:page_transition/page_transition.dart';

class TimeScreen extends StatefulWidget {
  int index;
  TimeScreen({super.key, required this.index});

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
                        const Text(
                          "Schedule",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: (() {
                                setState(() {
                                  studyTime.add(StudyTime(
                                      day: 0, startTime: 0, width: 180));
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: TimeDetailScreen(index: index),
                                    type: PageTransitionType.leftToRight,
                                    duration: const Duration(milliseconds: 500),
                                    reverseDuration:
                                        const Duration(milliseconds: 500)));
                          },
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
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Room : ${studyTime[widget.index].toString() ?? 'ไม่ระบุ'}",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                    Text(studyTime[widget.index].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                  ],
                                ),
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
