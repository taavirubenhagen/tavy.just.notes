import 'package:flutter/material.dart';
import 'package:just_notes/pages/home.dart';


bool lightMode = !false;


void main() {
  runApp(
    MaterialApp(
      title: 'Only Notes',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    ),
  );
}