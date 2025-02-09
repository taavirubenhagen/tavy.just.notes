import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_notes/db/db.dart';
import 'package:just_notes/just/just.dart';
import 'package:just_notes/main.dart';
import 'package:just_notes/pages/editor.dart';
import 'package:just_notes/util/util.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JustColors.background,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: lightMode ? Brightness.dark : Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  JustIcons.justAppBarIcon(
                    data: !lightMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    onTap: () => setState(() => lightMode = !lightMode),
                  ),
                  JustIcons.justAppBarIcon(
                    right: true,
                    data: Icons.menu_outlined,
                    onTap: () => JustBrand.showBottomSheet(context),
                  ),
                ],
              ),
            ),
            JustWidgets.divider,
            SizedBox(
              height: JustSizes.heightOf(context) - JustSizes.baseBarHeight -  JustSizes.keyboardHeightOf(context),
              child: FutureBuilder(
                future: allNotes(),
                builder: (context, snapshot) {
                  final n = snapshot.data;
                  if (n == null) {
                    return CircularProgressIndicator(
                      strokeWidth: 8,
                      color: JustColors.primary,
                    );
                  }
                  return ListView(
                    children: [
                      const SizedBox(height: 16),
                      for (final key in n.keys.toList().reversed)
                      GestureDetector(
                        onLongPress: () async {
                          if (await JustAuth.auth(n[key]?["locked"] ? "to permanently unlock note" : "to lock note")) {
                            await writeNote(
                              dateId: key,
                              title: n[key]?["title"],
                              body: n[key]?["body"],
                              locked: !n[key]?["locked"],
                            );
                            setState(() {});
                          }
                        },
                        onTap: () async {
                          if (!( n[key]?["locked"] ?? false ) || await JustAuth.auth("to access locked note")) {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => Editor(key, n[key], () => setState(() {})),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: JustSizes.comfortableBarHeight,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
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
                                    Row(
                                      children: [
                                        JustText.smallHeading(readableTitle(n[key])),
                                        const SizedBox(width: 8),
                                        FutureBuilder(
                                          future: JustAuth.supportsAuth,
                                          builder: (context, snapshot) {
                                            return ( n[key]?["locked"] ?? false ) && ( snapshot.data ?? false )
                                            ? JustIcons.baseTextIcon(Icons.lock)
                                            : const SizedBox();
                                          }
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    JustText.smallSubtitle(readableTitle(n[key], body: true)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Editor(null, null, () => setState(() {})),
                          ),
                        ),
                        child: Container(
                          width: JustSizes.widthOf(context),
                          height: JustSizes.comfortableBarHeight,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              JustIcons.mediumIcon(
                                Icons.add_outlined,
                                secondary: true,
                              ),
                              const SizedBox(width: 16),
                              JustText.baseButtonTitle(
                                'Write new',
                                color: JustColors.secondaryOnBackground,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}