import 'package:flutter/material.dart';
import 'package:haolearn/services/storage_service.dart';
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Testing data',
              ),
              Text("Table Name : ${data.table.name}"),
              Text("First Subject Name : ${data.table.subjectList.first.name}"),
              Text("First Subject Room : ${data.table.subjectList.first.room}"),
              Text(
                  "First Subject Day : ${data.table.subjectList.first.studyTimes.first.getDayName()}"),
              Text(
                  "First Subject Time : ${data.table.subjectList.first.studyTimes.first.getTimeName()}"),
              InkWell(
                onTap: () {
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
