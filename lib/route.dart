import 'package:flutter/material.dart';
import 'package:haolearn/screens/demo.dart';
import 'package:haolearn/screens/home.dart';
import 'package:haolearn/screens/subject_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/demo": (BuildContext context) => const DemoPage(),
  "/home": (BuildContext context) => const HomeScreen(),
  "/subject": (BuildContext context) => const SubjectScreen()
};
