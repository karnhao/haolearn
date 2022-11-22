import 'package:flutter/material.dart';
import 'package:haolearn/models/save.dart';
import 'package:haolearn/models/subject_table.dart';
import 'package:haolearn/services/storage_service.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    Save data = StorageService.getService().getSaveData()!;
    List<SubjectTable> sts = data
        .getMainTable()!
        .getSubjectTableList(day: 1, startTime: 480, endTime: 1260);
    return Scaffold(
        appBar: AppBar(title: const Text("Table")),
        body: ListView.builder(
            itemCount: sts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  color: Colors.red,
                  height: 50,
                  child: Text(
                      "${sts[index].name} ${sts[index].time.getTimeName()}"),
                ),
              );
            }));
  }
}
