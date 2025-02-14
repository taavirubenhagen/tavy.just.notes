import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_notes/just/just.dart';


abstract class JText {

  static const double baseSize = 14;

  static TextStyle get largeHeadingStyle => TextStyle(
    fontSize: baseSize + 4,
    fontWeight: FontWeight.bold,
    color: JustColors.foreground,
  );
  static Text largeHeading(String data) => Text(
    data,
    style: largeHeadingStyle,
  );
  
  static TextStyle get mediumHeadingStyle => TextStyle(
    fontSize: baseSize + 2,
    fontWeight: FontWeight.bold,
    color: JustColors.foreground,
  );
  static Text mediumHeading(String data, {Color? color}) => Text(
    data,
    style: mediumHeadingStyle.copyWith(color: color),
  );

  static TextStyle get smallHeadingStyle => TextStyle(
    fontSize: baseSize,
    fontWeight: FontWeight.bold,
    color: JustColors.foreground,
  );
  static Text smallHeading(String data, {Color? color}) => Text(
    data,
    style: smallHeadingStyle.copyWith(
      color: color ?? JustColors.foreground,
    ),
  );
  
  static Text mediumSubtitle(String data) => Text(
    data.replaceAll("\n\n", "\n"),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: mediumHeadingStyle.fontSize,
      color: JustColors.secondaryForeground,
    ),
  );

  static Text smallSubtitle(String data) => Text(
    data.replaceAll("\n\n", "\n"),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: baseSize,
      color: JustColors.secondaryForeground,
    ),
  );
  static Text censoredSmallSubtitle(String data) => Text(
    data.replaceAll("\n\n", "\n"),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.flowCircular(
      fontSize: baseSize,
      color: JustColors.secondaryForeground.withValues(
        alpha: 0.25,
      ),
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
