import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haolearn/screens/demo.dart';
import 'package:haolearn/screens/list_subject_screen.dart';
import 'package:haolearn/screens/task_screen.dart';
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

  Map<String, double> dataMap = {
    "Success": 75,
    "Not pass": 25,
  };
  List<Color> colorList = [
    Colors.blue,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kuSecColor,
        appBar: createKAppBar(context, "Home"),
        body: Container(
          color: kuSecColor,
          child: ListView(
            children: [
              Container(
                height: 225,
                decoration: const BoxDecoration(color: Colors.white),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 3000),
                  chartLegendSpacing: 24,
                  chartRadius: MediaQuery.of(context).size.width / 4.0,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 24,
                  centerText: "Read",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
              ),
              Container(
                height: 120,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)),
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
                                        type: PageTransitionType.leftToRight,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        reverseDuration:
                                            const Duration(milliseconds: 500)));
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
                                  "Debug",
                                  Icon(Icons.cancel,
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
