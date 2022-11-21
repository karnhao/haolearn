import 'package:flutter/material.dart';
import 'package:haolearn/utils/kappbar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createKAppBar(context, "Tasks"),
    );
  }
}
