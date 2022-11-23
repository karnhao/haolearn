import 'package:flutter/material.dart';
import 'package:haolearn/themes/colors.dart';

PreferredSize createKAppBar(BuildContext context, String title,
    {List<Widget> actions = const []}) {
  return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 110),
      child: Column(
        children: [
          Container(
            height: 110,
            color: kuSecColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  decoration: const BoxDecoration(
                      color: kuPriColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 40),
                    child: Row(
                      children: [
                        Visibility(
                          visible: Navigator.of(context).canPop(),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back,
                                size: 35, color: Colors.white),
                          ),
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
                const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: actions,
                )
              ],
            ),
          )
        ],
      ));
}
