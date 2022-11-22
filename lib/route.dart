import 'package:flutter/material.dart';
import 'package:haolearn/screens/Notes_Screen.dart';
import 'package:haolearn/screens/demo.dart';
import 'package:haolearn/screens/home.dart';
import 'package:haolearn/screens/note_subject_screen.dart';
import 'package:haolearn/screens/subject_screen.dart';
import 'package:haolearn/screens/list_subject_screen.dart';
import 'package:haolearn/screens/table_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/demo": (BuildContext context) => const DemoPage(),
  "/home": (BuildContext context) => const HomeScreen(),
  "/subject": (BuildContext context) => const SubjectScreen(
        index: 0,
      ),
  "/listsubject": (BuildContext context) => const ListSubjectScreen(),
  "/notesubject": (BuildContext context) => const NotesScreen(),
  "/table": (BuildContext context) => const TableScreen(),
  "/note": (BuildContext context) => const NoteSubjectScreen(),
};
