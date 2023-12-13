import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static void push(context, Widget page) {
    Navigator.push(context, PageTransition(type:  PageTransitionType.leftToRight, child: page));

  }

  static void pop(context) {
    Navigator.of(context).pop();
  }

  static void pushAndRemoveUntil(context,Widget page) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type:  PageTransitionType.leftToRight,
            child: page),
            (route) => false);
  }

  static void popUntil(context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
