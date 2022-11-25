import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haolearn/screens/demo.dart';
import 'package:haolearn/screens/list_subject_screen.dart';
import 'package:haolearn/screens/task_screen.dart';
import 'package:haolearn/services/storage_service.dart';
import 'package:haolearn/utils/kappbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:haolearn/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double iconSize = 60.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  List<Color> colorList = [
    Colors.blue,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    final data =
        StorageService.getService().getSaveData()!.getTaskCompletePercentage();
    final finishTaskCount = StorageService.getService()
        .getSaveData()!
        .tasks
        .where((t) => t.complete)
        .length;
    final notFinishTaskCount = StorageService.getService()
        .getSaveData()!
        .tasks
        .where((t) => !t.complete)
        .length;
    Map<String, double> dataMap = {
      "Finish $finishTaskCount Task${finishTaskCount == 1 ? '' : 's'}": data,
      "Remain $notFinishTaskCount Task${notFinishTaskCount == 1 ? '' : 's'}":
          100 - data
    };
    return Scaffold(
        backgroundColor: kuSecColor,
        appBar: createKAppBar(context, "Home", forceHidePopAction: true),
        body: Container(
          color: kuSecColor,
          child: ListView(
            children: [
              Container(
                height: 340,
                decoration: const BoxDecoration(color: Colors.white),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 3000),
                  chartLegendSpacing: 30,
                  chartRadius: MediaQuery.of(context).size.width / 3.4,
                  colorList: colorList,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.red,
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/table");
                              },
                              child: boxBottom(
                                  "Table",
                                  Icon(Icons.calendar_month,
                                      color: Colors.white, size: iconSize))),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.green,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const ListSubjectScreen(),
                                        type: PageTransitionType.leftToRight,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        reverseDuration:
                                            const Duration(milliseconds: 500)));
                              },
                              child: boxBottom(
                                  "Subject",
                                  Icon(Icons.book,
                                      color: Colors.white, size: iconSize))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.blue,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const TaskScreen(),
                                            type:
                                                PageTransitionType.leftToRight,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            reverseDuration: const Duration(
                                                milliseconds: 500)))
                                    .then((v) {
                                  setState(() {});
                                });
                              },
                              child: boxBottom(
                                  "Task",
                                  Icon(Icons.task,
                                      color: Colors.white, size: iconSize))),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.yellow,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const DemoPage(),
                                        type: PageTransitionType.leftToRight,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        reverseDuration:
                                            const Duration(milliseconds: 500)));
                              },
                              child: boxBottom(
                                  "Achievements",
                                  Icon(Icons.emoji_events,
                                      color: Colors.white, size: iconSize))),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget boxBottom(String title, Icon icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              title,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}
