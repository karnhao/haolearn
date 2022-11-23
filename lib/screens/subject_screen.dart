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
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final subjectList = data.mainTable.subjectList;

    return Scaffold(
        appBar: createKAppBar(context, subjectList[widget.index].name),
        body: Stack(children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Center(
              //   child: SizedBox(
              //     height: 50,
              //   ),
              // ),
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
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: "Name",
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.blue),
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
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: "Room",
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.blue),
                                borderRadius: BorderRadius.circular(25))),
                      )),
                ),
              ),
              // const SizedBox(height: 50),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           color: kuSecColor,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(50),
              //               topRight: Radius.circular(50))),
              //     ),
              //   ),
              // )
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
                              child: NotesScreen(),
                              type: PageTransitionType.leftToRight,
                              duration: const Duration(milliseconds: 500),
                              reverseDuration:
                                  const Duration(milliseconds: 500)));
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
