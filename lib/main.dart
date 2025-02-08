import 'package:flutter/material.dart';
import 'package:only_notes/pages/home.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Only Notes',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}