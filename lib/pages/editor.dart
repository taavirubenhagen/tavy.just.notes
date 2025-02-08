import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:only_notes/db/db.dart';
import 'package:only_notes/only/brand.dart';
import 'package:only_notes/only/buttons.dart';
import 'package:only_notes/only/colors.dart';
import 'package:only_notes/only/icons.dart';
import 'package:only_notes/only/sizes.dart';
import 'package:only_notes/only/text.dart';
import 'package:only_notes/only/widgets.dart';


class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  
  final _titleController = TextEditingController(
    text: DateTime.now().toIso8601String(),
  );
  final _titleFocusNode = FocusNode();
  
  final _bodyController = TextEditingController();
  final _bodyFocusNode = FocusNode();
  
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
                horizontal: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnlyButtons.onlyAppBarIcon(
                    data: Icons.lock_outlined,
                    onTap: () => !_bodyFocusNode.hasFocus
                    ? Navigator.pop(context)
                    : _bodyFocusNode.unfocus(),
                  ),
                  Container(
                    width: OnlySizes.widthOf(context) - 128,
                    height: OnlySizes.baseBarHeight,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      maxLines: 1,
                      decoration: InputDecoration.collapsed(
                        hintStyle: OnlyText.smallHeadingStyle.copyWith(
                          color: OnlyColors.secondary,
                        ),
                        hintText: "Note title",
                      ),
                      textAlign: TextAlign.center,
                      style: OnlyText.smallHeadingStyle,
                      cursorColor: OnlyColors.accent,
                      onTap: () => setState(() {}),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  OnlyButtons.onlyAppBarIcon(
                    right: true,
                    data: _titleFocusNode.hasFocus || _bodyFocusNode.hasFocus ? Icons.check_outlined : Icons.close_outlined,
                    onTap: _titleFocusNode.hasFocus || _bodyFocusNode.hasFocus
                    ? () async {
                      debugPrint(_bodyController.value.text);
                      _titleFocusNode.unfocus();
                      _bodyFocusNode.unfocus();
                      debugPrint("Here");
                      debugPrint(( await accessNotes(
                        dateId: "0",
                        title: _titleController.text,
                        body:_titleController.text,
                        locked: false,
                      ) )?.keys.toString());
                    }
                    : () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            OnlyWidgets.divider,
            Container(
              width: OnlySizes.widthOf(context),
              height: OnlySizes.heightOf(context) - OnlySizes.baseBarHeight - MediaQuery.viewInsetsOf(context).bottom,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              child: TextFormField(
                controller: _bodyController,
                focusNode: _bodyFocusNode,
                style: TextStyle(
                  fontSize: OnlyText.editorSize,
                ),
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(
                    fontSize: OnlyText.editorSize,
                    color: OnlyColors.secondary,
                  ),
                  hintText: _bodyFocusNode.hasFocus ? "Write here :)" : "Tap to edit",
                ),
                cursorColor: OnlyColors.accent,
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