import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/utils/utils.dart';

class EditScoreWidget extends StatefulWidget {
  final int index;
  final int subjectIndex;
  final Function(String topics, double scores, double fullScore) savedData;
  const EditScoreWidget(
      {super.key,
      required this.index,
      required this.savedData,
      required this.subjectIndex});

  @override
  State<EditScoreWidget> createState() => _EditScoreWidgetState();
}

class _EditScoreWidgetState extends State<EditScoreWidget> {
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final score =
        data.mainTable.subjectList[widget.subjectIndex].scores[widget.index];
    String title = score.name;
    double scores = score.score;
    double fullScores = score.maxScore;
    return AlertDialog(
        title: const Text("Edit"),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  title = value;
                },
                initialValue: title,
                decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    labelText: "Topics",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 1, color: Colors.blue))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  scores = double.parse(value);
                },
                initialValue: scores.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    labelText: "Scores",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 1, color: Colors.blue))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  fullScores = double.parse(value);
                },
                initialValue: fullScores.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    labelText: "Full scores",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(width: 1, color: Colors.blue))),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              score.name = title;
              score.score = scores;
              score.maxScore = fullScores;
              widget.savedData(title, scores, fullScores);

              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ]);
  }
}
