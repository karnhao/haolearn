import 'package:flutter/material.dart';

class notesScreen extends StatefulWidget {
  const notesScreen({super.key});

  @override
  State<notesScreen> createState() => _notesScreenState();
}

class _notesScreenState extends State<notesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Test"),
      ),
    );
  }
}
