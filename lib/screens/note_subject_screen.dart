import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        backgroundColor: kappBarColor,
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(20),
        children: [
          Container(
            height: 50,
            child: const Center(
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
          TextField(
            controller: TextEditingController(),
          )
        ],
      ),
    );
  }
}
