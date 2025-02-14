import 'package:flutter/material.dart';
import 'package:just_notes/pages/home.dart';
import 'package:just_notes/util/db.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.applyThemePreference();
  runApp(
    MaterialApp(
      title: 'Only Notes',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const Home("0"),
    ),
  );
}