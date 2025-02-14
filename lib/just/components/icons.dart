import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JIcons {
  
  static Widget baseTextIcon(IconData data, {bool secondary = false}) => Icon(
    data,
    size: JustText.baseSize,
    color: secondary ? JustColors.secondaryForeground : JustColors.foreground,
  );
  
  static Widget mediumIcon(IconData data, {Color? color}) => Icon(
    data,
    size: 24,
    color: color ?? JustColors.foreground,
  );
  
  static GestureDetector justAppBarIcon({
    bool right = false,
    Color? color,
    required IconData data,
    Function()? onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 64,
      padding: EdgeInsets.only(
        left: right ? 0 : 32,
        right: right ? 32 : 0,
      ),
      color: Colors.transparent,
      alignment: right ? Alignment.centerRight : Alignment.centerLeft,
      child: JustIcons.mediumIcon(
        data,
        color: color ?? (
          onTap == null
          ? JustColors.secondaryForeground
          : JustColors.foreground
        ),
      ),
    ),
  );
}