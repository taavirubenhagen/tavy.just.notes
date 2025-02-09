import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JWidgets {
  
  static get divider => Divider(
    height: 0,
    color: JustColors.foreground,
  );
  
  static Widget infoButton({
    JustButtonAction action = JustButtonAction.next,
    required BuildContext context,
    required String title,
    required String subtitle,
    required Function() onTap,
    Function()? onIconTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: JustSizes.baseBarHeight,
      padding: const EdgeInsets.only(
        left: 32,
      ),
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: JustSizes.widthOf(context) - 64 - 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JustText.smallHeading(title),
                const SizedBox(height: 2),
                JustText.smallSubtitle(subtitle),
              ],
            ),
          ),
          JustIcons.justAppBarIcon(
            right: true,
            data: JustIcons.actionIcon(action),
            onTap: onIconTap ?? onTap,
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
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      width: JustSizes.widthOf(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: JustColors.surface,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
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
                child: JustText.mediumHeading(title),
              ),
              const SizedBox(height: 32),
              child,
            ],
          ),
        ),
      ),
    ),
  );
}