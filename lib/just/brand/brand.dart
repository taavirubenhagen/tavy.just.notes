import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as icons;
import 'package:just_notes/just/just.dart';
import 'package:package_info_plus/package_info_plus.dart';


abstract class JBrand {
  
  static showBottomSheet(BuildContext context) => JustDialogs.showBottomSheet(
    context: context,
    title: "My Other Work",
    child: Column(
      children: [
        JustWidgets.infoButton(
          context: context,
          title: "Presentation Master 2",
          subtitle: "An all-in-one presentation controller",
          iconData: Icons.open_in_new_outlined,
          onTap: () => justLaunchUrl("https://play.google.com/store/apps/details?id=tavy.presenter.presentation_master_2"),
        ),
        Container(
          height: JustSizes.baseBarHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          alignment: Alignment.center,
          child: Builder(
            builder: (context) {
              const double iconSize = 24;
              const double spacing = 48;
              return Row(
                children: [
                  GestureDetector(
                    onTap: () => justLaunchUrl("https://rubenhagen.com"),
                    child: icons.Internet(
                      width: iconSize,
                      height: iconSize,
                      color: JustColors.foreground,
                    ),
                  ),
                  const SizedBox(width: spacing),
                  GestureDetector(
                    onTap: () => justLaunchUrl("https://github.com/taavirubenhagen"),
                    child: icons.Github(
                      width: iconSize,
                      height: iconSize,
                      color: JustColors.foreground,
                    ),
                  ),
                  const SizedBox(width: spacing),
                  GestureDetector(
                    onTap: () => justLaunchUrl("https://instagram.com/taavirubenhagen"),
                    child: icons.Instagram(
                      width: iconSize,
                      height: iconSize,
                      color: JustColors.foreground,
                    ),
                  ),
                  const SizedBox(width: spacing),
                  GestureDetector(
                    onTap: () => justLaunchUrl("https://threads.com/taavirubenhagen"),
                    child: icons.Threads(
                      width: iconSize,
                      height: iconSize,
                      color: JustColors.foreground,
                    ),
                  ),
                ],
              );
            }
          ),
        ),
        const SizedBox(height: 16),
        JustWidgets.divider,
        const SizedBox(height: 32),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => justLaunchUrl("https://play.google.com/store/apps/details?id=tavy.just.notes"),
                child: Container(
                  width: ( JustSizes.widthOf(context) - 64 ) / 3,
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) => JustText.smallButtonTitle(snapshot.data?.version ?? ""),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => justLaunchUrl("https://rubenhagen.com/legal/just"),
                child: Container(
                  width: ( JustSizes.widthOf(context) - 64 ) / 3,
                  height: 32,
                  alignment: Alignment.center,
                  child: JustText.smallButtonTitle("Privacy Policy"),
                ),
              ),
              GestureDetector(
                onTap: () => justLaunchUrl("https://rubenhagen.com/legal/imprint"),
                child: Container(
                  width: ( JustSizes.widthOf(context) - 64 ) / 3,
                  height: 32,
                  alignment: Alignment.centerRight,
                  child: JustText.smallButtonTitle("Imprint"),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}