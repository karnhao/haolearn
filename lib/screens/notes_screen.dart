import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haolearn/models/subject.dart';
import 'package:haolearn/screens/note_subject_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:haolearn/utils/delete_dialog_function.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:haolearn/utils/show_snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';

class NotesScreen extends StatefulWidget {
  final int index;
  const NotesScreen({super.key, required this.index});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Subject subject;
  bool reverseSort = true;

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
    subject.sortContentViaUnderstanding(reverse: reverseSort);
    final understand = subject.contents
        .map((t) => t.understanding.level)
        .fold(0, (previousValue, element) => previousValue + element);
    final maxUnderstand = subject.contents.length * 5;
    final value = understand / maxUnderstand * 100;
    Map<String, double> dataMap = {
      "Understand": value,
      "Not Understand": 100 - value
    };

    return Scaffold(
        appBar: createKAppBar(context, subject.name),
        body: ListView(
          children: [
            Container(
              alignment: AlignmentDirectional.center,
              height: 200,
              child: PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 3000),
                chartLegendSpacing: 30,
                chartRadius: MediaQuery.of(context).size.width / 3.4,
                colorList: const [Colors.blue, Colors.red],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 26,
                centerText: "Homework",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  decimalPlaces: 1,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: kuSecColor),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${subject.contents.length} Note${subject.contents.length == 1 ? '' : 's'}",
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w700)),
                          IconButton(
                              onPressed: () {
                                subject.addContent();
                                service.saveData().then((x) {
                                  Navigator.push(
                                          context,
                                          PageTransition(
                                              child: NoteSubjectScreen(
                                                  contentIndex:
                                                      subject.contents.length -
                                                          1,
                                                  subjectIndex: widget.index),
                                              type: PageTransitionType
                                                  .leftToRight,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              reverseDuration: const Duration(
                                                  milliseconds: 500)))
                                      .then((value) {
                                    setState(() {});
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
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
                  SizedBox(
                    height: 490,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.builder(
                        itemCount: subject.contents.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                              endActionPane: ActionPane(
                                  key: Key(index.toString()),
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      foregroundColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                      label: "Delete",
                                      icon: Icons.delete,
                                      onPressed: (context) {
                                        showDeleteDialog(
                                          context,
                                          onDeleteConfirm: () {
                                            subject.removeContent(index);

                                            service.saveData().then((value) {
                                              showSnackBar("Delete successful",
                                                  backgroundColor:
                                                      Colors.green);
                                              setState(() {});
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    SlidableAction(
                                      label: "Edit",
                                      backgroundColor: Colors.transparent,
                                      icon: Icons.edit,
                                      onPressed: (context) {
                                        Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: NoteSubjectScreen(
                                                        contentIndex: index,
                                                        subjectIndex:
                                                            widget.index),
                                                    type: PageTransitionType
                                                        .leftToRight,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    reverseDuration:
                                                        const Duration(
                                                            milliseconds: 500)))
                                            .then((v) {
                                          setState(() {});
                                        });
                                      },
                                    )
                                  ]),
                              child: boxTask(index));
                        },
                      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
                  context,
                  PageTransition(
                      child: NoteSubjectScreen(
                          contentIndex: index, subjectIndex: widget.index),
                      type: PageTransitionType.leftToRight,
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500)))
              .then((v) {
            setState(() {});
          });
        },
        child: Center(
          child: Container(
            height: 75,
            decoration: kuBoxStyle,
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
                      rating: subject.contents[index].understanding.level
                          .toDouble(),
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
      ),
    );
  }
}
