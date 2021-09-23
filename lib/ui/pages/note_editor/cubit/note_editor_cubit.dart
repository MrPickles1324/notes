import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_notes_repository/local_notes_repository.dart';
import 'package:notes/ui/pages/home/bloc/home_bloc.dart';

part 'note_editor_state.dart';

class NoteEditorCubit extends Cubit<NoteEditorState> {
  NoteEditorCubit({
    required HomeBloc homeBloc,
    required Note note,
  })  : _homeBloc = homeBloc,
        super(NoteEditorState(note));

  final HomeBloc _homeBloc;

  void done() {
    _homeBloc.add(CreateNote());
  }

  void delete() {
    _homeBloc.add(DeleteNote());
  }
}
