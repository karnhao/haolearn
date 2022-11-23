import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';

import '../models/subject.dart';

class NoteSubjectScreen extends StatefulWidget {
  final int index;
  const NoteSubjectScreen({super.key, required this.index});

  @override
  State<NoteSubjectScreen> createState() => _NoteSubjectScreenState();
}

class _NoteSubjectScreenState extends State<NoteSubjectScreen> {
  late Subject subject;
  bool toggle = false;
  bool update = true;
  String? nameChange;

  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    subject = data.getMainTable()!.subjectList[widget.index];

    if (update) {
      nameChange = subject.contents[widget.index].title;
      update = false;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text("ชื่อวิชา...", style: Theme.of(context).textTheme.headline2),
        backgroundColor: kuSecColor,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (value) {
                      nameChange = value;
                    },
                    initialValue: nameChange,
                    enabled: toggle,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: kuPriColor, width: 10)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: "Name Note",
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: kuPriColor),
                            borderRadius: BorderRadius.circular(25))),
                  )),
            ),
          ),
          const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Piority",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Center(
            child: RatingBar(
              minRating: 1,
              maxRating: 5,
              allowHalfRating: false,
              itemSize: 40,
              initialRating: 1,
              onRatingUpdate: (value) {},
              ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: Colors.amber),
                  half: const Icon(Icons.circle, color: Colors.amber),
                  empty: const Icon(
                    Icons.star_border_purple500_outlined,
                    color: Colors.grey,
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            onChanged: (value) {},
            maxLines: 20,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: "Text something...",
              labelText: "Note",
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
