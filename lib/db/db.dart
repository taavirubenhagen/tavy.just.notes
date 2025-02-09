import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, Map<String, dynamic>>?> allNotes() async {
  final instance = await SharedPreferences.getInstance();
  String? rawData = instance.getString("notes");
  if (rawData.runtimeType != String) {
    await instance.setString("notes", json.encode({
      "0": {
        "title": "Welcome :)",
        "body": "Thank you for using Just Notes.\n\n"
                "If your device supports biometrics, you can long press a note in the overview to lock it.\n\n"
                "Feel free to contact me if anything is unclear.",
        "locked": false,
      },
    }));
    rawData = instance.getString("notes");
    if (rawData == null) return null;
  }
  final currentNotes = Map<String, Map<String, dynamic>>.from(json.decode(rawData!));
  return currentNotes;
}


Future<Map<String, dynamic>?> writeNote({
  required String dateId,
  required String title,
  required String body,
  required bool locked,
}) async {
  final instance = await SharedPreferences.getInstance();
  final currentNotes = await allNotes();
  if (currentNotes == null) return null;
  currentNotes[dateId] = {
    "title": title,
    "body": body,
    "locked": locked,
  };
  await instance.setString("notes", json.encode(currentNotes));
  return currentNotes[dateId];
}


Future<void> deleteNote(String? dateId) async {
  final instance = await SharedPreferences.getInstance();
  final currentNotes = await allNotes();
  if (currentNotes == null || dateId == null) return;
  currentNotes.remove(dateId);
  await instance.setString("notes", json.encode(currentNotes));
  return;
}