import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_notes/just/just.dart';
import 'package:just_notes/util/db.dart';
import 'package:just_notes/util/notes.dart';


// ignore: must_be_immutable
class Editor extends StatefulWidget {
  Editor({
    required this.parentId,
    this.dateId,
    this.data,
    required this.setParentState,
    super.key,
  });

  String? parentId;
  String? dateId;
  Map<String, dynamic>? data;
  void Function(void Function()) setParentState;
  
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
          statusBarIconBrightness: JustColors.lightMode ? Brightness.dark : Brightness.light,
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
                    data: Icons.more_horiz_outlined,
                    onTap: () => NoteManager.options(
                        context: context,
                        id: widget.dateId,
                        data: widget.data,
                        setParentState: (f) => widget.setParentState(() {
                          f();
                          Navigator.pop(context);
                        }),
                      ),
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
                          color: JustColors.secondaryForeground,
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
                      await DB.write(
                        parentId: widget.parentId,
                        group: false,
                        id: widget.dateId,
                        data: widget.data,
                        title: _titleController.text,
                        body: _bodyController.text,
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
                style: JustText.editorStyle,
                decoration: InputDecoration.collapsed(
                  hintStyle: JustText.editorStyle.copyWith(
                    color: JustColors.secondaryForeground,
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