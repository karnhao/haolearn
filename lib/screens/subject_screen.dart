import 'package:flutter/material.dart';
import 'package:haolearn/screens/score_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final subjectList = data.mainTable.subjectList;

    return Scaffold(
        appBar: createKAppBar(context, subjectList[widget.index].name),
        body: Stack(children: [
          Column(
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
                              child: const ScoreScreen(index: 0),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                                  const Duration(milliseconds: 500)));
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: kuPriColor,
                      foregroundColor: kuSecColor,
                      child: Text('Score'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                      radius: 24,
                      backgroundColor: kuPriColor,
                      foregroundColor: kuSecColor,
                      child: Text('Time')),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/notesubject");
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: kuPriColor,
                      foregroundColor: kuSecColor,
                      child: Text('Note'),
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
