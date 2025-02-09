import 'package:flutter/material.dart';
import 'package:just_notes/main.dart';


abstract class JColors {
  static Color get background => lightMode ? Colors.white : Colors.black;
  static Color get surface => lightMode ? Colors.white : Colors.grey.shade900;
  static Color get primary => lightMode ? Colors.black : Colors.grey.shade400;
  static Color get secondary => lightMode ? Colors.grey.shade300 : Colors.grey.shade800;
  static Color get foreground => lightMode ? Colors.grey.shade900 : Colors.grey.shade100;
  static Color get onPrimary => lightMode ? Colors.white : Colors.black;
  static Color get onSecondary => lightMode ? Colors.black : Colors.white;
  static Color get secondaryOnBackground => lightMode ? Colors.grey.shade600 : Colors.grey.shade600;
}