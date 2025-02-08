import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


abstract class OnlyText {
  
  static const double baseSize = 14;
  static const double editorSize = 16;
  
  static Text mediumHeading(String data) => Text(
    data,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
  
  static TextStyle get smallHeadingStyle => TextStyle(
    fontSize: baseSize,
    fontWeight: FontWeight.bold,
  );
  static Text smallHeading(String data) => Text(
    data,
    style: smallHeadingStyle,
  );
  
  static Text smallSubtitle(String data) => Text(
    data,
    style: TextStyle(
      fontSize: baseSize,
      color: Colors.grey.shade600,
    ),
  );
  
  static Text buttonTitle(String data, {bool secondary = false}) => Text(
    data,
    style: TextStyle(
      fontSize: 16,
      color: secondary ? Colors.grey.shade600 : null,
    ),
  );
}