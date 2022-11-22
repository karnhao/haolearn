import 'package:flutter/material.dart';
import 'package:haolearn/models/study_time.dart';
import 'package:haolearn/models/subject.dart';
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
              Text("Table Name : ${data.mainTable.name}"),
              Text(
                  "First Subject Name : ${data.mainTable.subjectList.first.name}"),
              Text(
                  "First Subject Room : ${data.mainTable.subjectList.first.room}"),
              Text(
                  "First Subject Day : ${data.mainTable.subjectList.first.studyTimes.first.getDayName()}"),
              Text(
                  "First Subject Time : ${data.mainTable.subjectList.first.studyTimes.first.getTimeName()}"),
              InkWell(
                onTap: () {
                  data.getMainTable()!.subjectList.clear();
                  data.tasks.clear();
                  Subject testSubject = Subject(name: "Biolody");
                  testSubject.studyTimes
                      .add(StudyTime(day: 1, startTime: 500, width: 50));
                  Subject testSubject2 =
                      Subject(name: "Introduction to Computer Science");
                  testSubject.studyTimes
                      .add(StudyTime(day: 1, startTime: 600, width: 60));
                  data.getMainTable()!.subjectList.add(testSubject);
                  data.getMainTable()!.subjectList.add(testSubject2);
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
