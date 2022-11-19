import 'package:flutter/material.dart';
import 'package:haolearn/services/storage_service.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  final String title = "Haolearn";

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final service = StorageService.getService();

  @override
  Widget build(BuildContext context) {
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
              Text("Table Name : ${service.getSaveData()!.table.name}"),
              Text(
                  "First Subject Name : ${service.getSaveData()!.table.subjectList.first.name}"),
              Text(
                  "First Subject Room : ${service.getSaveData()!.table.subjectList.first.room}"),
              Text(
                  "First Subject Day : ${service.getSaveData()!.table.subjectList.first.studyTimes.first.getDayName()}"),
              Text(
                  "First Subject Time : ${service.getSaveData()!.table.subjectList.first.studyTimes.first.getTimeName()}"),
              InkWell(
                onTap: () {
                  service.getSaveData()!.table.name += "!";
                  service.getSaveData()!.save().then(((v) {
                    setState(() {});
                  }));
                },
                child: Container(
                  color: Colors.yellow,
                  height: 50,
                  width: 150,
                  child: const Center(child: Text("Click here")),
                ),
              )
            ],
          ),
        ));
  }
}
