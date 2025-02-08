import 'package:flutter/material.dart';


abstract class OnlySizes {
  static const double baseBarHeight = 80;
  static const double comfortableBarHeight = 96;
  static widthOf(context) => MediaQuery.sizeOf(context).width;
  static heightOf(context) => MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).collapsedSize.height;
}