import 'dart:developer';
import 'dart:math' as math;

import 'package:awrad/Consts/ThemeCosts.dart';
import 'package:awrad/widgets/BkScaffold.dart';
import 'package:awrad/widgets/MyScf.dart';
import 'package:flutter/material.dart';

class MyMasbaha extends StatefulWidget {
  MyMasbaha({Key key}) : super(key: key);

  @override
  _MyMasbahaState createState() => _MyMasbahaState();
}

class _MyMasbahaState extends State<MyMasbaha>
    with SingleTickerProviderStateMixin {
  Animation<double> anim;
  Animation<double> anim2;
  AnimationController controller;
  bool hasCompleted = false;
  final duratio = 300;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: duratio), value: 0);
    anim = Tween<double>(begin: 0.0, end: 3.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCirc))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                activeIndex++;
              });
              controller.value = 0;
            }
          });

    anim2 = Tween<double>(begin: 0.0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCirc))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.value = 0;
            }
          });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int activeIndex = 2;
  final max = 33;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final mainColor = Colors.white;
    return BkScaffold(
      child: InkWell(
        onTap: () {
          log("activeIndex $activeIndex");
          if (activeIndex > max + 1) {
            setState(() {
              activeIndex = 2;
            });
          } else {
            controller.forward();
          }

          // setState(() {
          //   activeIndex++;
          // });

          log("activeIndex2 $activeIndex");
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final ballSize = maxWidth / 8;
            return Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    width: media.width,
                    color: AppColors.mainColorSelected,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: media.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 40,
                                      color: mainColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        activeIndex = 2;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.replay,
                                      size: 40,
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "33/",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: mainColor,
                                    ),
                                  ),
                                  Text(
                                    "${activeIndex - 2}",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: media.width * 0.5,
                          child: Image.asset(
                            "assets/masBk.png",
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Divider(
                          color: Colors.green,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          for (var i = activeIndex - 3;
                              i < activeIndex + 3;
                              i++)
                            ...{_getContainer(ballSize, i)}.toList()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _getContainer(double ballSize, int index) {
    final correctedIndex = index - (activeIndex - 2);
    final normalPos = ((correctedIndex + anim2.value) * ballSize);
    final finalPos = correctedIndex < 3
        ? correctedIndex == 2 ? normalPos + (anim.value * ballSize) : normalPos
        : normalPos + (3 * ballSize);

    // final normalBot = 5 * ballSize;
    // final animVal = anim2.value;
    // final maxVal = 50;
    // final upVal = animVal * 2 * maxVal;
    // final downVal = maxVal - (animVal * maxVal);
    // if (anim.value <= 0.5)
    //   log("Up $upVal");
    // else
    //   log("Down $downVal");
    // final activeBot = anim2.value <= 0.8 ? upVal : downVal;
    return Positioned(
      left: finalPos,
      // bottom: correctedIndex == 2 ? normalBot + activeBot : normalBot,
      child: Container(
        width: ballSize,
        height: ballSize,
        child: Center(
            child: Stack(
          children: <Widget>[
            Transform.rotate(
                angle: 0,
                // angle: correctedIndex == 2 ? anim2.value : 0,
                child: Image.asset("assets/mas.png")),
            Align(
                alignment: Alignment.center,
                child: Text(correctedIndex != 3 ? "" : "${index - 3}"))
          ],
        )),
      ),
    );
  }
}
