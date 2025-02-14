import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';
import 'package:just_notes/pages/home.dart';
import 'package:just_notes/util/db.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class Settings {
  
  static void options({
    required BuildContext context,
    required void Function(void Function()) setParentState,
  }) {
    JustDialogs.showBottomSheet(
      context: context,
      title: "Settings",
      child: Column(
        children: [
          JustWidgets.infoButton(
            context: context,
            title: JustColors.lightMode ? "Turn the Lights Off" : "Turn the Lights On",
            subtitle: JustColors.lightMode ? "Switch to Dark Mode" : "Switch to Light Mode",
            iconData: JustColors.lightMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            onTap: () async {
              Navigator.pop(context);
              await DB.toggleThemePreference(setParentState);
            },
          ),
          /*const SizedBox(height: 16),
          JustWidgets.divider,
          const SizedBox(height: 16),*/
          JustWidgets.infoButton(
            context: context,
            title: "Download My Notes",
            subtitle: '... as "Notes Data.json"',
            iconData: Icons.download_outlined,
            onTap: () {
              Navigator.pop(context);
              JustDialogs.choice(
                context: context,
                title: 'Create and Open "Notes Data.json"?',
                primaryTitle: "Open",
                onPrimaryTap: () async {
                  Navigator.pop(context);
                  await DB.clean();
                  if (!( await Permission.manageExternalStorage.isGranted )) {
                    await Permission.manageExternalStorage.request();
                  }
                  String? path = ( await getExternalStorageDirectory() )?.path;
                  if (Platform.isAndroid) {
                    path = "/storage/emulated/0/Download";
                  }
                  debugPrint(path);
                  if (path != null) {
                    final file = await File('$path/Notes Data.json').writeAsString(await DB.completeJson);
                    OpenFile.open(file.path);
                  }
                },
              );
            },
          ),
          JustWidgets.infoButton(
            context: context,
            title: "Restore Notes",
            subtitle: '... from JSON File',
            iconData: Icons.restore_page_outlined,
            onTap: () {
              Navigator.pop(context);
              JustDialogs.choice(
                context: context,
                title: 'Upload Backup File',
                primaryTitle: "Browse",
                onPrimaryTap: () async {
                  Navigator.pop(context);
                  // TODO: JustDialogs.info only with 1 "Yay!" button
                  JustDialogs.choice(
                    context: context,
                    info: true,
                    title: 'Restored 4 Items',
                    primaryTitle: "Yay!",
                    onPrimaryTap: () => Navigator.pop(context),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}