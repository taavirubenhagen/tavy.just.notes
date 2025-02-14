import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';
import 'package:just_notes/util/db.dart';


abstract class NoteManager {

  static String readableTitle(Map<String, dynamic>? data, {body = false, headline = true, String? fallback}) {
    if (body) {
      String body = data?["body"] ?? ( headline ? "No Text" : "no text" );
      if (body == "") return "[No Text]";
      return body;
    }
    String? title = data?["title"];
    if (title == null || title == "") {
      return fallback ?? (
        data?["items"] == null || data?["items"].isEmpty
        ? headline ? "Untitled Note" : "untitled note"
        : headline ? "Untitled Group" : "untitled group"
      );
    }
    return title;
  }


  static void options({
    required BuildContext context,
    required String? id,
    required Map<String, dynamic>? data,
    required void Function(void Function()) setParentState,
  }) {
    final controller = TextEditingController(
      text: readableTitle(
        data,
        fallback: "Options",
      ),
    );
    final focusNode = FocusNode();
    JustDialogs.showBottomSheet(
      context: context,
      title: StatefulBuilder(
        builder: (ctx, setInnerState) {
          return Stack(
            children: [
              Row(
                children: [
                  Text(
                    "${controller.text}  ",
                    style: JustText.largeHeadingStyle.copyWith(
                      color: Colors.transparent,
                    ),
                  ),
                  // TODO: JustIcons.fromTextStyle(...)
                  if (data?[DataKeys.title] != null && !focusNode.hasFocus) JustIcons.mediumIcon(
                    Icons.edit,
                    color: JustColors.inactive,
                  ),
                ],
              ),
              TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration.collapsed(
                  hintStyle: JustText.largeHeadingStyle.copyWith(
                    color: JustColors.secondaryForeground,
                  ),
                  hintText: "Note title",
                ),
                style: JustText.largeHeadingStyle,
                onTap: () => setInnerState(() {}),
                onChanged: (value) => setInnerState(() => DB.write(
                  id: id,
                  data: data,
                  title: value,
                )),
                onFieldSubmitted: (_) => Navigator.pop(context),
              ),
            ],
          );
        }
      ),
      child: Column(
        children: [
          FutureBuilder(
            future: JustAuth.supportsAuth,
            builder: (context, snapshot) => !( snapshot.data ?? true )
            ? const SizedBox()
            : JustWidgets.infoButton(
              context: context,
              title: ( data?["locked"] ?? false) ? "Unlock" : "Lock",
              subtitle: "Swipe Left",
              iconData: ( data?["locked"] ?? false) ? Icons.lock : Icons.lock_outlined,
              onTap: id == null
              ? null
              : () async {
                Navigator.pop(context);
                if (await JustAuth.auth(( data?["locked"] ?? false) ? "to permanently unlock note" : "to lock note")) {
                  await DB.write(
                    id: id,
                    data: data,
                    locked: !data?["locked"],
                  );
                  setParentState(() {});
                }
              },
            ),
          ),
          JustWidgets.infoButton(
            context: context,
            title: ( data?["pinned"] ?? false) ? "Unpin" : "Pin",
            subtitle: "Swipe Right",
            iconData: ( data?["pinned"] ?? false) ? Icons.push_pin : Icons.push_pin_outlined,
            onTap: id == null
            ? null
            : () async {
              Navigator.pop(context);
              await DB.write(
                id: id,
                data: data,
                pinned: !( data?["pinned"] ?? false ),
              );
              setParentState(() {});
            },
          ),
          JustWidgets.infoButton(
            context: context,
            title: ( data?[DataKeys.reminderMilliseconds] ?? 0 ) == 0 ? "Edit Reminder" : "Set Reminder",
            subtitle: "Tap Here",
            iconData: ( data?[DataKeys.reminderMilliseconds] ?? 0 ) == 0
            ? Icons.notifications_active
            : Icons.notification_add_outlined,
            onTap: id == null
            ? null
            : () async {
              Navigator.pop(context);
              await DB.write(
                id: id,
                data: data,
                reminder: ( data?[DataKeys.reminderMilliseconds] ?? 0 ) == 0 ? 1000 : 0,
              );
              debugPrint("data?[DataKeys.reminderMilliseconds].toString()");
              setParentState(() {});
            },
          ),
          JustWidgets.infoButton(
            context: context,
            title: "Add to Group",
            subtitle: "Drag and Drop",
            iconData: Icons.library_add_outlined,
          ),
          JustWidgets.infoButton(
            context: context,
            critical: true,
            title: "Delete",
            subtitle: "Double Tap",
            iconData: Icons.remove_circle_outline_outlined,
            onTap: () async {
              Navigator.pop(context);
              delete(
                context: context,
                id: id,
                data: data,
                setParentState: setParentState,
              );
            },
          ),
        ],
      ),
    );
  }

  static void delete({
    required BuildContext context,
    required String? id,
    required Map<String, dynamic>? data,
    required void Function(void Function()) setParentState,
  }) => JustDialogs.choice(
    context: context,
    title: "Delete ${readableTitle(data, headline: false)}?",
    primaryTitle: "Delete",
    onPrimaryTap: () async {
      Navigator.pop(context);
      await DB.delete(id);
      setParentState(() {});
    },
  );
}
