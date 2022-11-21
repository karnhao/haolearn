import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home", style: Theme.of(context).textTheme.headline2)),
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: 380,
          child: Container(
              height: 420,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: const Color.fromARGB(255, 140, 140, 140)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (() {}),
                        child: boxBottom(
                            "Calendar",
                            const Icon(
                              Icons.calendar_month,
                              size: 100,
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/listsubject");
                        },
                        child: boxBottom(
                            "List Subject",
                            const Icon(
                              Icons.calendar_month,
                              size: 100,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/demo");
                        },
                        child: boxBottom(
                            "Debug",
                            const Icon(
                              Icons.calendar_month,
                              size: 100,
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: boxBottom(
                            "Setting",
                            const Icon(
                              Icons.calendar_month,
                              size: 100,
                            )),
                      ),
                    ],
                  )
                ],
              )),
        ),
        Positioned(
          top: 390,
          width: 200,
          right: 105,
          child: Container(
            width: 150,
            height: 8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20)),
          ),
        )
      ]),
    );
  }

  Widget boxBottom(String title, Icon icon) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 98, 98, 98),
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
    );
  }
}
