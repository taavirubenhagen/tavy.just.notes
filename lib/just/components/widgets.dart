import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';


abstract class JWidgets {
  
  static get divider => Divider(
    height: 0,
    color: JustColors.foreground,
  );
  
  static Widget infoButton({
    required BuildContext context,
    double? width,
    bool comfortableHeight = false,
    bool critical = false,
    required String title,
    List<Widget>? customTitleBadges,
    List<IconData?>? titleBadges,
    bool subtitleCensored = false,
    String? subtitle,
    // TODO: Make required?
    IconData? iconData,
    Function()? onTap,
    Function()? onIconTap,
    Function()? onDoubleTap,
  }) => GestureDetector(
    onTap: onTap,
    onDoubleTap: onDoubleTap,
    child: Container(
      width: width ?? JustSizes.widthOf(context),
      height: comfortableHeight ? JustSizes.comfortableBarHeight : JustSizes.baseBarHeight,
      padding: const EdgeInsets.only(
        left: 32,
      ),
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    subtitle == null
                    ? JustText.mediumHeading(
                      title,
                      color: critical
                      ? JustColors.bad
                      : onTap == null && onIconTap == null
                        ? JustColors.inactive
                        : null,
                    )
                    : JustText.smallHeading(
                      title,
                      color: critical
                      ? JustColors.bad
                      : onTap == null && onIconTap == null
                        ? JustColors.inactive
                        : null,
                    ),
                    const SizedBox(width: 8),
                    for (final data in titleBadges ?? [])
                    ...[
                      JustIcons.baseTextIcon(data),
                      const SizedBox(width: 2),
                    ],
                    if (titleBadges != null && titleBadges.isNotEmpty) const SizedBox(width: 8),
                    for (final badge in customTitleBadges ?? [])
                    ...[
                      badge,
                      const SizedBox(width: 2),
                    ],
                  ],
                ),
                if (subtitle != null) const SizedBox(height: 2),
                if (subtitle != null) subtitleCensored
                ? JustText.censoredSmallSubtitle(subtitle)
                : JustText.smallSubtitle(subtitle),
              ],
            ),
          ),
          if (iconData != null) JustIcons.justAppBarIcon(
            right: true,
            color: critical
            ? JustColors.bad
            : onTap == null && onIconTap == null
              ? JustColors.inactive
              : null,
            data: iconData,
            onTap: onIconTap ?? onTap,
          ),
        ],
      ),
    ),
  );
}