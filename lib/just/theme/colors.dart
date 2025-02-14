import 'package:flutter/material.dart';


abstract class JColors {
  static bool lightMode = true;
  
  static Color get background => lightMode ? Colors.white : Colors.black;
  static Color get surface => lightMode ? Colors.white : Colors.grey.shade900;
  static Color get primary => lightMode ? Colors.black : Colors.grey.shade400;
  static Color get secondary => lightMode ? Colors.grey.shade300 : Colors.grey.shade800;
  static Color get accent => lightMode ? Colors.brown : Colors.brown.shade600;
  static Color get good => lightMode ? Colors.green : Colors.green;
  static Color get bad => lightMode ? Colors.red : Colors.red;
  static Color get foreground => lightMode ? Colors.grey.shade900 : Colors.grey.shade100;
  static Color get secondaryForeground => lightMode ? Colors.grey.shade600 : Colors.grey.shade600;
  static Color get inactive => lightMode ? Colors.grey.shade400 : Colors.grey.shade700;
  static Color get onPrimary => lightMode ? Colors.white : Colors.black;
  static Color get onSecondary => lightMode ? Colors.black : Colors.white;
}
