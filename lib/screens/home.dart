import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haolearn/screens/demo.dart';
import 'package:haolearn/screens/list_subject_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:haolearn/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        appBar: AppBar(
            backgroundColor: kappBarColor,
            title: Text("Home", style: Theme.of(context).textTheme.headline2),
            centerTitle: true),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: SizedBox(
                height: 225,
                // color: Colors.white,
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 3000),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/table");
                },
                child: boxBottom("Table", const Icon(Icons.calendar_month))),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const ListSubjectScreen(),
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 500)));
                },
                child: boxBottom("Subject", const Icon(Icons.book))),
            boxBottom("Task", const Icon(Icons.task)),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const DemoPage(),
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 500)));
                },
                child: boxBottom("Debug", const Icon(Icons.cancel))),
          ],
        ));
  }

  Widget boxBottom(String title, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 87, 156, 50),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
