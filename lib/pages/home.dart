import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_notes/util/db.dart';
import 'package:just_notes/just/just.dart';
import 'package:just_notes/pages/editor.dart';
import 'package:just_notes/util/notes.dart';
import 'package:just_notes/util/settings.dart';


class Home extends StatefulWidget {
  const Home(this.id, {super.key});
  
  final String id;

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
          statusBarIconBrightness: JustColors.lightMode ? Brightness.dark : Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            JustAppBar(
              left: widget.id == DBKeys.rootGroupId ? Icons.settings_outlined : Icons.arrow_back_outlined,
              onLeftTap: () => widget.id == DBKeys.rootGroupId
              ? Settings.options(
                context: context,
                setParentState: setState,
              )
              : Navigator.pop(context),
            ),
            JustWidgets.divider,
            SizedBox(
              height: JustSizes.heightOf(context) - JustSizes.baseBarHeight -  JustSizes.keyboardHeightOf(context),
              child: FutureBuilder(
                future: DB.all,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.only(
                        bottom: JustSizes.baseBarHeight,
                      ),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: JustColors.primary,
                      ),
                    );
                  }
                  final dbItems = snapshot.data!;
                  List allIds = dbItems.keys.where((k) => dbItems[k]![DataKeys.parent] == widget.id).toList().reversed.toList();
                  final groupIds = allIds.where((e) => dbItems[e]![DataKeys.isGroup]).toList();
                  final noteIds = allIds.where((e) => !dbItems[e]![DataKeys.isGroup]).toList();
                  groupIds.sort((a, b) => dbItems[a]?[DataKeys.isPinned] ?? false ? 0 : 1);
                  noteIds.sort((a, b) => dbItems[a]?[DataKeys.isPinned] ?? false ? 0 : 1);
                  allIds = groupIds + noteIds;
                  return ListView(
                    children: [
                      const SizedBox(height: 16),
                      for (final key in allIds)
                      ...[
                        //JustText.smallHeading("Notes"),
                        //for (final key in keys)
                        FutureBuilder(
                          future: JustAuth.supportsAuth,
                          builder: (context, snapshot) {
                            final button = Row(
                              children: [
                                JustWidgets.infoButton(
                                  context: context,
                                  comfortableHeight: true,
                                  title: NoteManager.readableTitle(dbItems[key]),
                                  customTitleBadges: [
                                    if ( dbItems[key]?[DataKeys.isGroup] ?? false )
                                    JustText.mediumSubtitle(
                                      dbItems.values.where((v) => v[DataKeys.parent] == key).length.toString(),
                                    ),
                                  ],
                                  titleBadges: [
                                    if (( dbItems[key]?[DataKeys.isLocked] ?? false ) && ( snapshot.data ?? false ))
                                    Icons.lock,
                                    if (dbItems[key]?[DataKeys.isPinned] ?? false )
                                    Icons.push_pin,
                                    if (( dbItems[key]?[DataKeys.reminderMilliseconds] ?? 0 ) == 0)
                                    Icons.notifications,
                                  ],
                                  subtitleCensored: dbItems[key]?["locked"],
                                  subtitle: dbItems[key]![DataKeys.isGroup]
                                  ? null
                                  : NoteManager.readableTitle(
                                    dbItems[key],
                                    body: true,
                                    headline: true,
                                  ),
                                  iconData: Icons.more_horiz_outlined,
                                  onTap: () async {
                                    if (!( dbItems[key]?[DataKeys.isLocked] ?? false ) || await JustAuth.auth("to access locked note")) {
                                      Navigator.push(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => dbItems[key]?[DataKeys.isGroup]
                                          ? Home(key)
                                          : Editor(
                                            parentId: widget.id,
                                            dateId: key,
                                            data: dbItems[key],
                                            setParentState: setState,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  onIconTap: () => NoteManager.options(
                                    context: context,
                                    id: key,
                                    data: dbItems[key],
                                    setParentState: setState,
                                  ),
                                  onDoubleTap: () => NoteManager.delete(
                                    context: context,
                                    id: key,
                                    data: dbItems[key],
                                    setParentState: setState,
                                  ),
                                ),
                              ],
                            );
                            return Draggable<String>(
                              data: key,
                              feedback: Material(
                                borderRadius: BorderRadius.circular(16),
                                color: JustColors.accent.withValues(
                                  alpha: 0.25,
                                ),
                                child: button,
                              ),
                              childWhenDragging: const SizedBox(),
                              child: DragTarget<String>(
                                onAcceptWithDetails: (details) async {
                                  if (details.data == key) return;
                                  String? newGroupId = key;
                                  if (!dbItems[key]![DataKeys.isGroup]) {
                                    newGroupId = await DB.write(
                                      parentId: widget.id,
                                      id: null,
                                      data: {},
                                      group: true,
                                      title: "${dbItems[key]![DataKeys.title]}, ${dbItems[details.data]![DataKeys.title]}",
                                    );
                                    await DB.write(
                                      parentId: newGroupId,
                                      id: key,
                                      data: dbItems[key],
                                    );
                                  }
                                  await DB.write(
                                    parentId: newGroupId,
                                    id: details.data,
                                    data: dbItems[details.data],
                                  );
                                  setState(() {});
                                },
                                builder: (context, _, _) => button,
                              ),
                            );
                          }
                        ),
                      ],
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Editor(
                              parentId: widget.id,
                              setParentState: setState,
                            ),
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
                                color: JustColors.secondaryForeground,
                              ),
                              const SizedBox(width: 16),
                              JustText.baseButtonTitle(
                                'Write new',
                                color: JustColors.secondaryForeground,
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


class JustAppBar extends StatefulWidget {
  const JustAppBar({
    required this.left,
    required this.onLeftTap,
    super.key,
  });
  
  final IconData left;
  final Function() onLeftTap;
  //IconData icon2Data;
  //Function() icon2onTap;

  @override
  State<JustAppBar> createState() => _JustAppBarState();
}

class _JustAppBarState extends State<JustAppBar> {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        JustIcons.justAppBarIcon(
          data: widget.left,
          onTap: widget.onLeftTap,
        ),
        JustIcons.justAppBarIcon(
          right: true,
          data: Icons.menu_outlined,
          onTap: () => JustBrand.showBottomSheet(context),
        ),
      ],
    ),
  );
  }
}