import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notes_repository/local_notes_repository.dart';
import 'package:notes/ui/pages/home/bloc/home_bloc.dart';
import 'package:notes/ui/pages/home/widgets/notes_gird.dart';
import 'package:notes/ui/pages/note_editor/view/note_editor_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text(_getAppBarText(state.notesStatus)),
          ),
          body: _getBody(state),
          floatingActionButton: OpenContainer(
            closedBuilder: (context, action) => FloatingActionButton(
              onPressed: action,
              child: const Icon(Icons.add),
            ),
            openBuilder: (context, action) =>
                NoteEditorPage(newNote: true, note: Note.empty),
          ),
        );
      },
    );
  }

  Widget _getBody(HomeState state) {
    switch (state.notesStatus) {
      case NotesStatus.ready:
        return NotesGrid(state: state);
      case NotesStatus.loading:
        return _loading();
      case NotesStatus.empty:
        return _empty();
    }
  }

  String _getAppBarText(NotesStatus status) {
    switch (status) {
      case NotesStatus.empty:
        return "Empty";
      case NotesStatus.loading:
        return "Loading";
      case NotesStatus.ready:
        return "Ready";
    }
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _empty() {
    return const Center(
      child: Text("Nothing to show"),
    );
  }
}
