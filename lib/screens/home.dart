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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 235, 235)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 0),
              const Center(
                  child: Text("Null Learn",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700))),
              SizedBox(
                height: 410,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.table_chart_outlined,
                                  color: Colors.white),
                              Text("Table")
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/subject");
                          },
                          child: Container(
                            width: 160,
                            height: 160,
                            color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.book_outlined, color: Colors.white),
                                Text("Subject")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/demo");
                          },
                          child: Container(
                            width: 160,
                            height: 160,
                            color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.error_outline, color: Colors.white),
                                Text("Debug Zone")
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 160,
                          color: Colors.pink,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.settings, color: Colors.white),
                              Text("Settings")
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
