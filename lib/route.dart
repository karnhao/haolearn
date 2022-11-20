import 'package:flutter/material.dart';
import 'package:haolearn/screens/demo.dart';
import 'package:haolearn/screens/home.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/demo": (BuildContext context) => const DemoPage(),
  "/home": (BuildContext context) => const HomeScreen(),
};
