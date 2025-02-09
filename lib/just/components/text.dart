import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JText {
  
  static const double baseSize = 14;
  
  static Text mediumHeading(String data) => Text(
    data,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: JustColors.foreground,
    ),
  );
  
  static TextStyle get smallHeadingStyle => TextStyle(
    fontSize: baseSize,
    fontWeight: FontWeight.bold,
    color: JustColors.foreground,
  );
  static Text smallHeading(String data) => Text(
    data,
    style: smallHeadingStyle,
  );
  
  static Text smallSubtitle(String data) => Text(
    data,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: baseSize,
      color: JustColors.secondaryOnBackground,
    ),
  );
  
  static Text baseButtonTitle(String data, {Color? color}) => Text(
    data,
    style: TextStyle(
      fontSize: 16,
      color: color ?? JustColors.foreground,
    ),
  );
  
  static Text smallButtonTitle(String data, {Color? color}) => Text(
    data,
    style: TextStyle(
      fontSize: 14,
      color: color ?? JustColors.foreground,
    ),
  );
  
  static TextStyle get editorStyle => TextStyle(
    fontSize: 16,
    height: 1.25,
    wordSpacing: 0,
    letterSpacing: 0,
    color: JustColors.foreground,
  );
}