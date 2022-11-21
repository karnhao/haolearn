import 'package:flutter/material.dart';

PreferredSize createKAppBar(BuildContext context, String title) {
  return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 110),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 60,
            color: const Color.fromARGB(255, 178, 187, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 102, 100),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 40),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back,
                              size: 40, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(title,
                            style: Theme.of(context).textTheme.headline1),
                      ],
                    ),
                  ),
                ),
                const SizedBox()
              ],
            ),
          )
        ],
      ));
}
