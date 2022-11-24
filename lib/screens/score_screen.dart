import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haolearn/models/subject_score.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_function.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/show_snack_bar.dart';

class ScoreScreen extends StatefulWidget {
  final int index;
  const ScoreScreen({super.key, required this.index});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    final service = StorageService.getService();
    final data = service.getSaveData()!;
    final subjectList = data.mainTable.subjectList;
    final scoreList = subjectList[widget.index].scores;

    return Scaffold(
      appBar: createKAppBar(context, subjectList[widget.index].name),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: kuSecColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${scoreList.length.toString()} Score${scoreList.length == 1 ? "" : 's'}",
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          IconButton(
                              onPressed: (() {
                                setState(() {
                                  scoreList.add(const SubjectScore(
                                      name: "Unname", score: 0, maxScore: 0));
                                  service.saveData();
                                });
                              }),
                              icon: const Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.white,
                              ))
                        ])),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  height: 5,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: scoreList.length,
                      itemBuilder: ((context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                    onPressed: (context) {
                                      showDeleteDialog(
                                        context,
                                        onDeleteConfirm: () {
                                          scoreList.removeAt(index);
                                          service.saveData().then((value) {
                                            showSnackBar("Delete successful",
                                                backgroundColor: Colors.green);
                                            setState(() {});
                                          });
                                        },
                                      );
                                    },
                                    label: "Delete",
                                    icon: Icons.delete,
                                    autoClose: true,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.red),
                                SlidableAction(
                                    onPressed: (context) {},
                                    label: "Edit",
                                    icon: Icons.edit,
                                    autoClose: true,
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 22),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kuPriColor,
                                  borderRadius: BorderRadius.circular(20)),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    subjectList[widget.index]
                                        .scores[index]
                                        .name,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  Text(
                                    "18 / 20",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
