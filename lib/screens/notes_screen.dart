import 'package:flutter/material.dart';
import 'package:haolearn/themes/colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Note Subject"),
        centerTitle: true,
        
      ),
    );
  }
}
