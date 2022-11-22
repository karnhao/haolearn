import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haolearn/themes/colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Note Subject",
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          backgroundColor: kuSecColor,
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              alignment: AlignmentDirectional.center,
              height: 200,
              child: const Text("Note 10 note"),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [Text("Name"), Text("Star")],
                    ),
                  ),
                  SizedBox(
                    height: 490,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return boxTask(index);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget boxTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/note");
        },
        child: Container(
          height: 75,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(115, 205, 205, 205)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text('Title$index'),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: RatingBarIndicator(
                    rating: 3,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
