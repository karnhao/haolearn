import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haolearn/utils/kappbar.dart';

class TimeDetailScreen extends StatefulWidget {
  int index;
  TimeDetailScreen({super.key, required this.index});

  @override
  State<TimeDetailScreen> createState() => _TimeDetailScreenState();
}

class _TimeDetailScreenState extends State<TimeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createKAppBar(context, "Schedule"),
      body: Stack(),
    );
  }
}
