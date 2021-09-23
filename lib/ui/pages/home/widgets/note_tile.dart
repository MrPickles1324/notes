import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:local_notes_repository/local_notes_repository.dart';
import 'package:notes/ui/pages/home/bloc/home_bloc.dart';
import 'package:notes/ui/pages/note_editor/view/note_editor_page.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.note,
    required this.state,
  }) : super(key: key);

  final Note note;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        child: Column(
          children: [
            Text(note.title),
            Text(note.content),
          ],
        ),
      ),
      openBuilder: (context, action) => NoteEditorPage(
        newNote: false,
        note: note,
      ),
    );
  }
}
