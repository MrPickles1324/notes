import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notes_repository/local_notes_repository.dart';
import 'package:notes/ui/pages/home/bloc/home_bloc.dart';
import 'package:notes/ui/pages/note_editor/cubit/note_editor_cubit.dart';
import 'package:notes/ui/pages/note_editor/view/note_editor_view.dart';
import 'package:provider/provider.dart';

class NoteEditorPage extends StatelessWidget {
  const NoteEditorPage({
    required this.newNote,
    required this.note,
    Key? key,
  }) : super(key: key);

  final bool newNote;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteEditorCubit(
        homeBloc: context.read<HomeBloc>(),
        note: note,
      ),
      child: NoteEditorView(
        newNote: newNote,
      ),
    );
  }
}
