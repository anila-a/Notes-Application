import 'package:flutter/material.dart';
import 'package:note_app/screens/note_list.dart';
import 'package:note_app/screens/note_details.dart';

void main() {
  runApp(NoteApp()); //call my widget
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: NoteList(),
    );
  }
}
