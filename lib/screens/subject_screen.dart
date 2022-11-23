import 'package:flutter/material.dart';
import 'package:haolearn/screens/notes_screen.dart';
import 'package:haolearn/screens/score_screen.dart';
import 'package:haolearn/screens/time.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_alert.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:page_transition/page_transition.dart';

class SubjectScreen extends StatefulWidget {
  final int index;
  const SubjectScreen({super.key, required this.index});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  bool toggle = false;
  bool update = true;
  String? nameChange;
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final subjectList = data.mainTable.subjectList;

    if (update) {
      nameChange = subjectList[widget.index].name;
      update = false;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: createKAppBar(context, subjectList[widget.index].name),
        body: Stack(children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
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
                          initialValue: subjectList[widget.index].name,
                          enabled: toggle,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide:
                                      BorderSide(color: kuPriColor, width: 10)),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: "Subject",
                              labelStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: kuPriColor),
                                  borderRadius: BorderRadius.circular(25))),
                        )),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        initialValue: subjectList[widget.index].room,
                        enabled: toggle,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide:
                                    BorderSide(color: kuPriColor, width: 10)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: "Room",
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
              ),
              InkWell(
                onTap: () {
                  subjectList[widget.index].name = nameChange ?? "ERROR";

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
            bottom: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(

                              ///ToDo
                              child: ScoreScreen(index: widget.index),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                                  const Duration(milliseconds: 500)));
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: kuPriColor,
                      foregroundColor: kuSecColor,
                      child:
                          Text('Score', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: TimeScreen(),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                                  const Duration(milliseconds: 500)));
                    },
                    child: CircleAvatar(
                        radius: 24,
                        backgroundColor: kuPriColor,
                        foregroundColor: kuSecColor,
                        child: Text('Time')),

                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: NotesScreen(index: widget.index),

                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                                  const Duration(milliseconds: 500)));
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: kuPriColor,
                      foregroundColor: kuSecColor,
                      child:
                          Text('Note', style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                const DeleteConfirm(),
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
        ]));
  }
}
