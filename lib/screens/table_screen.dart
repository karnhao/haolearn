import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/table.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  bool loaded = false;
  late Widget table;
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
        appBar: createKAppBar(context, "Table"),
        body: createTableWidget(context));
  }
}
