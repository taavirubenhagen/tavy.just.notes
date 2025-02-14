import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JDialogs {
  
  static void showBottomSheet({
    required BuildContext context,
    required title,
    required Widget child,
  }) => showModalBottomSheet(
    context: context,
    scrollControlDisabledMaxHeightRatio: 0.75,
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
                child: title.runtimeType == String
                ? JustText.largeHeading(title)
                : title,
              ),
              const SizedBox(height: 32),
              child,
            ],
          ),
        ),
      ),
    ),
  );
  
  static void choice({
    required BuildContext context,
    bool info = false,
    required String title,
    required String primaryTitle,
    Function()? onPrimaryTap,
    String secondaryTitle = "Cancel"
  }) => showBottomSheet(
    context: context,
    title: title,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Row(
        children: [
          if (!info) Expanded(
            child: JustButtons.text(
              secondary: true,
              onTap: () => Navigator.pop(context),
              title: secondaryTitle,
            ),
          ),
          if (!info) const SizedBox(width: 16),
          Expanded(
            child: JustButtons.text(
              onTap: onPrimaryTap ?? () => Navigator.pop(context),
              title: primaryTitle,
            ),
          ),
        ],
      ),
    ),
  );
}