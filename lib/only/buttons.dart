import 'package:flutter/material.dart';
import 'package:only_notes/only/icons.dart';


abstract class OnlyButtons {
  static GestureDetector onlyAppBarIcon({
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
      child: OnlyIcons.mediumIcon(
        data,
      ),
    ),
  );
}