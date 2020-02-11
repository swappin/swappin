import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FadeNavigator extends CupertinoPageRoute {
  static Widget page;

  FadeNavigator()
      : super(builder: (BuildContext context) => page);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: page);
  }
}
