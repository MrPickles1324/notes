import 'package:flutter/material.dart';

class NoteEditorView extends StatelessWidget {
  const NoteEditorView({required this.newNote, Key? key}) : super(key: key);

  final bool newNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            
            decoration: const InputDecoration.collapsed(hintText: "Note"),
            autofocus: newNote,
          )
        ],
      ),
    );
  }
}
