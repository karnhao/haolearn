import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_alert.dart';
import 'package:haolearn/utils/show_snack_bar.dart';

import '../models/subject.dart';

class NoteSubjectScreen extends StatefulWidget {
  final int contentIndex;
  final int subjectIndex;
  const NoteSubjectScreen(
      {super.key, required this.subjectIndex, required this.contentIndex});

  @override
  State<NoteSubjectScreen> createState() => _NoteSubjectScreenState();
}

class _NoteSubjectScreenState extends State<NoteSubjectScreen> {
  late Subject subject;
  bool toggle = false;
  bool update = true;
  String? nameChange;
  String? descriptionChange;

  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    subject = data.getMainTable()!.subjectList[widget.subjectIndex];

    if (update) {
      nameChange = subject.contents[widget.contentIndex].title;
      descriptionChange = subject.contents[widget.contentIndex].description;
      update = false;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(nameChange!, style: Theme.of(context).textTheme.headline2),
        backgroundColor: kuSecColor,
      ),
      body: Stack(
        children: [
          ListView(
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

                      //MARK
                      child: TextFormField(
                        onChanged: (value) {
                          nameChange = value;
                        },
                        initialValue: nameChange,
                        enabled: toggle,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide:
                                    BorderSide(color: kuPriColor, width: 10)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: "Name Note",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: kuPriColor),
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

              //MARK Rating Star
              Center(
                child: RatingBar(
                  minRating: 1,
                  maxRating: 5,
                  allowHalfRating: false,
                  itemSize: 40,
                  initialRating: 1,
                  onRatingUpdate: (value) {
                    showSnackBar("Sevice unvalible");
                  },
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

              //MARK
              TextFormField(
                enabled: toggle,
                onChanged: (value) {
                  descriptionChange = value;
                },
                initialValue: descriptionChange,
                maxLines: 10,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Text something...",
                  labelText: "Note",
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kuPriColor, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  subject.contents[widget.contentIndex].title =
                      nameChange ?? "ERROR";
                  subject.contents[widget.contentIndex].description =
                      descriptionChange ?? "ERROR";

                  service.saveData().then((v) {
                    setState(() {});
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(50),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: kuPriColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.save,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Row(
              children: [
                DeleteConfirm(
                  function: () {
                    subject.removeContent(widget.contentIndex);
                    service.saveData();
                    Navigator.pop(context);
                  },
                ),
                InkWell(
                    onTap: () {},
                    child: Switch(
                      value: toggle,
                      onChanged: (value) {
                        setState(
                          () {
                            toggle = value;
                          },
                        );
                      },
                      activeColor: Colors.green,
                      activeTrackColor: Colors.lightGreenAccent,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
