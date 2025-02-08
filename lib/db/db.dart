import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, Map<String, dynamic>>?> accessNotes({
  String? dateId,
  String? title,
  String? body,
  bool? locked,
}) async {
  debugPrint("currentNoteData");
  final instance = await SharedPreferences.getInstance();
  final currentNoteData = instance.getString("notes");
  debugPrint(currentNoteData);
  if (currentNoteData.runtimeType != String) await instance.setString("notes", json.encode({}));
  final currentNoteJson = json.decode(currentNoteData!);
  if (currentNoteJson.runtimeType != Map<String, Map<String, dynamic>>) return null;
  final Map<String, Map<String, dynamic>> currentNotes = currentNoteJson;
  if ([dateId, title, body, locked].contains(null)) return currentNoteJson;
  currentNotes[dateId!] = {
    "title": title,
    "body": body,
    "locked": locked,
  };
  await instance.setString("notes", json.encode(currentNotes));
  return currentNotes;
}