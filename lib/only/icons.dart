import 'package:flutter/material.dart';


enum ButtonAction {
  external,
  next,
}


abstract class OnlyIcons {
  
  static Widget mediumIcon(IconData data, {bool secondary = false}) => Icon(
    data,
    size: 24,
    color: secondary ? Colors.grey.shade600 : null,
  );
  
  static actionIcon(ButtonAction action) => switch (action) {
    ButtonAction.external => Icons.open_in_new_outlined,
    ButtonAction.next => Icons.arrow_forward_outlined,
  };
}