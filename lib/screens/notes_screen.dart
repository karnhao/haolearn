import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/screens/note_subject_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:page_transition/page_transition.dart';

class NotesScreen extends StatefulWidget {
  final int index;
  const NotesScreen({super.key, required this.index});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Subject subject;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    subject = data.getMainTable()!.subjectList[widget.index];

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () {
            setState(() {
              subject.addContent();
            });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Note Subject",
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          backgroundColor: kuSecColor,
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // decoration: BoxDecoration(
              //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
              alignment: AlignmentDirectional.center,
              height: 200,
              child: const Text("Note 10 note"),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: kuSecColor),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Name",
                            style: Theme.of(context).textTheme.headline2),
                        Text("Star",
                            style: Theme.of(context).textTheme.headline2)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 490,
                    child: ListView.builder(
                      itemCount: subject.contents.length,
                      itemBuilder: (context, index) {
                        return boxTask(index);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget boxTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
                  context,
                  PageTransition(
                      child: NoteSubjectScreen(index: index),
                      type: PageTransitionType.leftToRight,
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500)))
              .then((v) {
            setState(() {});
          });
          ;
        },
        child: Container(
          height: 75,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: kuPriColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(subject.contents[index].title,
                    style: Theme.of(context).textTheme.headline2),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: RatingBarIndicator(
                    rating:
                        subject.contents[index].understanding.level.toDouble(),
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
