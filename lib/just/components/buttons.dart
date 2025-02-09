import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JButtons {
  
  static Widget text({
    bool secondary = false,
    required String title,
    required Function() onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: secondary ? JustColors.secondary : JustColors.primary,
      ),
      alignment: Alignment.center,
      child: JustText.baseButtonTitle(
        title,
        color: secondary ? JustColors.onSecondary : JustColors.onPrimary,
      ),
    ),
  );
}