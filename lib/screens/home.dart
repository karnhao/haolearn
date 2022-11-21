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
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),

        // Container(
        //   height: 180,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        //       color: Colors.amber),
        // ),

        // height: MediaQuery.of(context).size.height,
        Positioned(
          top: 410,
          child: Container(
              height: 510,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: const Color.fromARGB(255, 140, 140, 140)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    ),
                  )
                ],
              )),
        ),
        Positioned(
          top: 420,
          width: 200,
          right: 105,
          child: Container(
            width: 150,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
        )
      ]),
    );
  }
}
