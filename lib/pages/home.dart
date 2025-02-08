import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:only_notes/only/brand.dart';
import 'package:only_notes/only/icons.dart';
import 'package:only_notes/only/sizes.dart';
import 'package:only_notes/only/text.dart';
import 'package:only_notes/only/widgets.dart';
import 'package:only_notes/pages/editor.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              padding: EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => OnlyBrand.showBottomSheet(context),
                    child: OnlyIcons.mediumIcon(
                      Icons.person_outline_outlined,
                    ),
                  ),
                  OnlyIcons.mediumIcon(
                    Icons.settings_outlined,
                  ),
                ],
              ),
            ),
            OnlyWidgets.divider,
            SizedBox(
              height: OnlySizes.heightOf(context) - OnlySizes.baseBarHeight,
              child: ListView(
                children: [
                  SizedBox(height: 16),
                  OnlyWidgets.infoButton(
                    large: true,
                    title: "Hoffmanns",
                    subtitle: "Jute-Beutel vorgedruckt, ansonsten\nselbst Sachen mitbringen    Sticker ...",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Editor(),
                      ),
                    ),
                  ),
                  OnlyWidgets.infoButton(
                    large: true,
                    title: "Mubi",
                    subtitle: "Weizenfeld",
                    onTap: () {},
                  ),
                  OnlyWidgets.infoButton(
                    large: true,
                    title: "[No Title]",
                    subtitle: "Die AfD war einmal eine unbedeutende\nKleinstpartei. Erst durch die Stimmen ...",
                    onTap: () {},
                  ),
                  Container(
                    height: 96,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OnlyIcons.mediumIcon(
                          Icons.add_outlined,
                          secondary: true,
                        ),
                        SizedBox(width: 16),
                        OnlyText.buttonTitle(
                          'Write new',
                          secondary: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}