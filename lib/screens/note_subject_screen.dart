import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/themes/colors.dart';

class NoteSubjectScreen extends StatefulWidget {
  const NoteSubjectScreen({super.key});

  @override
  State<NoteSubjectScreen> createState() => _NoteSubjectScreenState();
}

class _NoteSubjectScreenState extends State<NoteSubjectScreen> {
  @override
  Widget build(BuildContext context) {
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
