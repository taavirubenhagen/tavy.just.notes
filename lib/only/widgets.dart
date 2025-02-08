import 'package:flutter/material.dart';
import 'package:only_notes/only/colors.dart';
import 'package:only_notes/only/icons.dart';
import 'package:only_notes/only/sizes.dart';
import 'package:only_notes/only/text.dart';


abstract class OnlyWidgets {
  
  static get divider => Divider(
    height: 0,
    color: Colors.black,
  );
  
  static Widget infoButton({
    bool large = false,
    ButtonAction action = ButtonAction.next,
    required String title,
    required String subtitle,
    required Function() onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: large ? OnlySizes.comfortableBarHeight : OnlySizes.baseBarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: 32,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnlyText.smallHeading(title),
              OnlyText.smallSubtitle(subtitle),
            ],
          ),
          Icon(
            OnlyIcons.actionIcon(action),
          ),
        ],
      ),
    ),
  );
  
  static showBottomSheet({
    required BuildContext context,
    required String title,
    required Widget child,
  }) => showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: OnlySizes.widthOf(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: OnlyColors.background,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: OnlyText.mediumHeading(title),
              ),
              SizedBox(height: 32),
              child,
            ],
          ),
        ),
      ),
    ),
  );
}