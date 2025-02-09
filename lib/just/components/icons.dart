import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JIcons {
  
  static Widget baseTextIcon(IconData data, {bool secondary = false}) => Icon(
    data,
    size: JustText.baseSize,
    color: secondary ? JustColors.secondaryOnBackground : JustColors.foreground,
  );
  
  static Widget mediumIcon(IconData data, {bool secondary = false}) => Icon(
    data,
    size: 24,
    color: secondary ? JustColors.secondaryOnBackground : JustColors.foreground,
  );
  
  static actionIcon(JustButtonAction action) => switch (action) {
    JustButtonAction.delete => Icons.remove_circle_outline_outlined,
    JustButtonAction.external => Icons.open_in_new_outlined,
    JustButtonAction.next => Icons.arrow_forward_outlined,
  };
  
  static GestureDetector justAppBarIcon({
    bool right = false,
    required IconData data,
    required Function() onTap,
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
      ),
    ),
  );
}