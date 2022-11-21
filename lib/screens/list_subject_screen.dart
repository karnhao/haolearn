import 'package:flutter/material.dart';

class ListSubjectScreen extends StatefulWidget {
  const ListSubjectScreen({super.key});

  @override
  State<ListSubjectScreen> createState() => _ListSubjectScreenState();
}

class _ListSubjectScreenState extends State<ListSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "List Subject",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: 600,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 138, 138, 138),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subject",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                      Row(children: [
                        IconButton(
                            onPressed: (() {}),
                            icon: const Icon(
                              Icons.delete,
                              size: 40,
                            )),
                        IconButton(
                            onPressed: (() {}),
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                            ))
                      ])
                    ]),
              ),
              Container(
                height: 5,
                width: 360,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 520,
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 22),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 80, 80),
                              borderRadius: BorderRadius.circular(20)),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    })),
              )
            ],
          ),
        ))
      ]),
    );
  }
}
