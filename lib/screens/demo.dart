import 'package:flutter/material.dart';
import 'package:haolearn/models/notification_model.dart';
import 'package:haolearn/models/priority.dart' as model;
import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/models/subject_content.dart';
import 'package:haolearn/models/task.dart';
import 'package:haolearn/services/notification_service.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/show_snack_bar.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  final String title = "Haolearn";

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final service = StorageService.getService();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final data = service.getSaveData()!;
    return Scaffold(
        appBar: createKAppBar(context, "DEBUG SCREEN", actions: [
          InkWell(
            onTap: () {
              showSnackBar("AAARRRGGHH!!!");
            },
            child: const Icon(Icons.cancel),
          ),
        ]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Testing data',
              ),
              InkWell(
                onTap: () {
                  data.getMainTable()!.subjectList.clear();
                  data.tasks.clear();
                  Task task1 = Task(
                      title: "PDPA",
                      description:
                          "Do PDPA powerpoint and present in front of the class!",
                      dueDate: DateTime.now()
                          .add(const Duration(days: 1, seconds: 10)),
                      priority: model.Priority.high,
                      score: 100);
                  final dueDate = task1.dueDate;
                  task1.registerNotification(
                      NotificationModel(
                          title: "Homework Due tomorrow",
                          message: "${task1.title} - ${task1.description}",
                          id: 0,
                          showTime: DateTime(
                              dueDate!.year,
                              dueDate.month,
                              dueDate.day - 1,
                              dueDate.hour,
                              dueDate.minute,
                              dueDate.second,
                              dueDate.millisecond,
                              dueDate.microsecond)),
                      NotificationChannel.homework);
                  data.tasks.add(Task(
                      title: "PDPA",
                      description:
                          "Do PDPA powerpoint and present in front of the class!",
                      dueDate: DateTime.now()
                          .add(const Duration(days: 1, minutes: 1)),
                      priority: model.Priority.high,
                      score: 100));
                  data.tasks.add(Task(
                      title: "English Speaking 3",
                      description: "Record a speaking video for 5 minutes",
                      dueDate:
                          DateTime.now().add(const Duration(days: 2, hours: 2)),
                      priority: model.Priority.high,
                      score: 15));
                  data.tasks.add(Task(
                      title: "Play games with cat",
                      description: "Give ball to the cat and pet the dog.",
                      priority: model.Priority.lowest,
                      score: 0));
                  data.tasks.add(Task(
                      title: "Play games with rabbit",
                      description: "Make cat and rabbit play together!",
                      priority: model.Priority.low,
                      score: 20));
                  Subject testSubject = Subject(name: "Biolody");
                  Subject testSubject2 =
                      Subject(name: "Introduction to Computer Science");
                  Subject testSubject3 = Subject(name: "Calculas II");
                  testSubject.studyTimes
                      .add(StudyTime(day: 1, startTime: 500, width: 120));
                  testSubject.studyTimes
                      .add(StudyTime(day: 3, startTime: 500, width: 120));
                  testSubject2.studyTimes
                      .add(StudyTime(day: 1, startTime: 680, width: 60));
                  testSubject2.studyTimes
                      .add(StudyTime(day: 2, startTime: 680, width: 60));
                  testSubject2.studyTimes
                      .add(StudyTime(day: 5, startTime: 680, width: 60));
                  testSubject3.studyTimes
                      .add(StudyTime(day: 1, startTime: 740, width: 240));
                  testSubject2.addContent(
                      title: "Bitwise Operators I",
                      description: "Bitwise I Operators is hard",
                      understanding: ContentUnderstanding.high);
                  testSubject2.addContent(
                      title: "Bitwise Operators II",
                      description: "Bitwise II Operators is hardest",
                      understanding: ContentUnderstanding.lowest);
                  testSubject.room = "SC-709";
                  testSubject2.room = "LH1-504";
                  testSubject3.room = "SC-708";
                  data.getMainTable()!.subjectList.add(testSubject);
                  data.getMainTable()!.subjectList.add(testSubject2);
                  data.getMainTable()!.subjectList.add(testSubject3);
                  service.saveData();

                  showSnackBar("Hello");
                },
                child: Container(
                  color: Colors.yellow,
                  height: 25,
                  width: 150,
                  child: const Center(child: Text("Click here")),
                ),
              ),
              selectedDate == null
                  ? InkWell(
                      onTap: () {
                        _selectDate(context).then((v) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        color: Colors.grey,
                        height: 25,
                        width: 150,
                        child: const Center(child: Text("Select Date")),
                      ),
                    )
                  : Container(
                      color: Colors.red,
                      height: 25,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 110,
                            child: Text(
                                "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                style: const TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 40,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedDate = null;
                                  });
                                },
                                child: const Icon(Icons.close)),
                          ),
                        ],
                      )),
            ],
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year + 1, DateTime.now().month, DateTime.now().day));

    if (date != null && date != selectedDate) selectedDate = date;
  }
}
