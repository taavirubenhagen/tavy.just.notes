import 'package:flutter/material.dart';


abstract class JSizes {
  static const double baseBarHeight = 80;
  static const double comfortableBarHeight = 96;
  static double widthOf(context) => MediaQuery.sizeOf(context).width;
  static double heightOf(context) => MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).collapsedSize.height;
  static double keyboardHeightOf(context) => MediaQuery.viewInsetsOf(context).bottom;
}