import 'package:flutter/material.dart';
import 'package:only_notes/only/icons.dart';
import 'package:only_notes/only/sizes.dart';
import 'package:only_notes/only/text.dart';
import 'package:only_notes/only/widgets.dart';
import 'package:url_launcher/url_launcher.dart';


abstract class OnlyBrand {
  
  static showBottomSheet(BuildContext context) => OnlyWidgets.showBottomSheet(
    context: context,
    title: "Check out my other apps ☺",
    child: Column(
      children: [
        OnlyWidgets.infoButton(
          title: "Presentation Master 2",
          subtitle: "An all-in-one presentation controller",
          action: ButtonAction.external,
          onTap: () => launchUrl(
            Uri(
              path: "https://play.google.com/store/apps/details?id=tavy.presenter.presentation_master_2",
            ),
          ),
        ),
        if (false) OnlyWidgets.infoButton(
          title: "Presentation Master 2",
          subtitle: "An all-in-one presentation controller",
          action: ButtonAction.external,
          onTap: () => launchUrl(
            Uri(
              path: "https://play.google.com/store/apps/details?id=tavy.presenter.presentation_master_2",
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}