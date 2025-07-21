import 'package:flutter/material.dart';
import 'package:haolearn/themes/colors.dart';
import 'package:marquee/marquee.dart';

PreferredSize createKAppBar(BuildContext context, String title,
    {List<Widget> actions = const [], bool forceHidePopAction = false}) {
  final style = Theme.of(context).textTheme.displayLarge;
  final Size size = (TextPainter(
          text: TextSpan(text: title, style: style),
          maxLines: 1,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textDirection: TextDirection.ltr)
        ..layout())
      .size;
  return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 54),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.top,
            decoration: const BoxDecoration(color: Colors.black),
          ),
          SizedBox(
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 54,
                  decoration: BoxDecoration(
                      color: kuPriColor,
                      borderRadius:
                          size.width <= MediaQuery.of(context).size.width - 111
                              ? const BorderRadius.only(
                                  bottomRight: Radius.circular(20))
                              : null),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: Navigator.of(context).canPop() && !forceHidePopAction,
                          child: InkWell(
                            onTap: () {
                              Navigator.maybePop(context);
                            },
                            child: const Icon(Icons.arrow_back,
                                size: 35, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 111),
                          child: size.width >
                                  MediaQuery.of(context).size.width - 111
                              ? Marquee(
                                  text: title, blankSpace: 100, style: style)
                              : Text(
                                  title,
                                  style: style,
                                ),
                        )
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
