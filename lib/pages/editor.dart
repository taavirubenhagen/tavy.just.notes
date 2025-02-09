import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_notes/db/db.dart';
import 'package:just_notes/just/just.dart';
import 'package:just_notes/main.dart';
import 'package:just_notes/util/util.dart';


// ignore: must_be_immutable
class Editor extends StatefulWidget {
  Editor(this.dateId, this.data, this.setParentState, {super.key});

  String? dateId;
  Map<String, dynamic>? data;
  Function() setParentState;
  
  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  
  final _titleController = TextEditingController();
  final _titleFocusNode = FocusNode();
  
  final _bodyController = TextEditingController();
  final _bodyFocusNode = FocusNode();
  
  //bool _locked = false;
  
  @override
  initState() {
    super.initState();
    _titleController.text = widget.data?["title"] ?? "";
    _bodyController.text = widget.data?["body"] ?? "";
  }
  
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
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  JustIcons.justAppBarIcon(
                    data: Icons.remove_circle_outline_outlined,
                    onTap: () {
                      if (_titleController.text == "" && _bodyController.text == "" && widget.dateId == null) {
                        Navigator.pop(context);
                        return;
                      }
                      return JustWidgets.showBottomSheet(
                        context: context,
                        title: "Delete ${readableTitle(widget.data, headline: false)}?",
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: JustButtons.text(
                                  secondary: true,
                                  onTap: () => Navigator.pop(context),
                                  title: "Cancel",
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: JustButtons.text(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    await deleteNote(widget.dateId);
                                    widget.setParentState();
                                  },
                                  title: "Delete",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: JustSizes.widthOf(context) - 128,
                    height: JustSizes.baseBarHeight,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      maxLines: 1,
                      decoration: InputDecoration.collapsed(
                        hintStyle: JustText.smallHeadingStyle.copyWith(
                          color: JustColors.secondaryOnBackground,
                        ),
                        hintText: "Note title",
                      ),
                      textAlign: TextAlign.center,
                      style: JustText.smallHeadingStyle,
                      onTap: () => setState(() {}),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  JustIcons.justAppBarIcon(
                    right: true,
                    data: ( _titleFocusNode.hasFocus || _bodyFocusNode.hasFocus )
                    && ( _bodyController.text != "" || _titleController.text != "" )
                    ? Icons.check_outlined
                    : Icons.close_outlined,
                    onTap: () async {
                      if (_titleFocusNode.hasFocus || _bodyFocusNode.hasFocus) {
                        _titleFocusNode.unfocus();
                        _bodyFocusNode.unfocus();
                      }
                      if (_titleController.text == "" && _bodyController.text == "" && widget.dateId == null) {
                        Navigator.pop(context);
                        return;
                      }
                      await writeNote(
                        dateId: widget.dateId ?? DateTime.now().toIso8601String(),
                        title: _titleController.text,
                        body: _bodyController.text,
                        locked: false,//_locked,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            JustWidgets.divider,
            Container(
              width: JustSizes.widthOf(context),
              height: JustSizes.heightOf(context) - JustSizes.baseBarHeight - MediaQuery.viewInsetsOf(context).bottom,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              child: TextFormField(
                controller: _bodyController,
                focusNode: _bodyFocusNode,
                minLines: 1,
                maxLines: 1024,
                textAlign: TextAlign.justify,
                style: JustText.editorStyle,
                decoration: InputDecoration.collapsed(
                  hintStyle: JustText.editorStyle.copyWith(
                    color: JustColors.secondaryOnBackground,
                  ),
                  hintText: _bodyFocusNode.hasFocus ? "Write here :)" : "Tap to edit",
                ),
                onTap: () => setState(() {}),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}