import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_notes_repository/firebase_notes_repository.dart';
import 'package:local_notes_repository/local_notes_repository.dart';
import 'package:notes/authentication_bloc/authentication_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required AuthenticationBloc authenticationBloc})
      : _authenticationBloc = authenticationBloc,
        super(HomeState(notes: [], notesStatus: NotesStatus.loading)) {
    if (_authenticationBloc.state is Authenticated) {
      _firebaseNotesRepository = FirebaseNotesRepository();
    }
    _localNotesRepository =
        LocalNotesRepository(onDbInitialized: onDbInitialized);
  }

  void onDbInitialized() {
    add(UpdateNotes());
  }

  late final LocalNotesRepository _localNotesRepository;
  late final FirebaseNotesRepository? _firebaseNotesRepository;
  final AuthenticationBloc _authenticationBloc;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is UpdateNotes) {
      yield await _mapUpdateNotesToState(event, state);
    } else if (event is CreateNote) {
      yield* _mapCreateNoteToState(state);
    } else if (event is DeleteNote) {
      yield* _mapDeleteNoteToState(state);
    }
  }

  Stream<HomeState> _mapDeleteNoteToState(HomeState state) async* {}

  Stream<HomeState> _mapCreateNoteToState(HomeState state) async* {}

  Future<HomeState> _mapUpdateNotesToState(
    UpdateNotes event,
    HomeState state,
  ) async {
    List<Note> notes = [];
    var localNotes = _localNotesRepository.getNotes().then(
          (value) => notes.addAll(value),
        );
    var firebaseNotes =
        _getFirebaseNotes().then((value) => notes.addAll(value));

    await localNotes;
    await firebaseNotes;
    if (notes.isEmpty) {
      return state.copyWith(
        notes: [],
        notesStatus: NotesStatus.empty,
      );
    } else {
      notes.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
      return state.copyWith(notes: notes, notesStatus: NotesStatus.ready);
    }
  }

  Future<List<Note>> _getFirebaseNotes() async {
    if (_authenticationBloc.state is Unauthenticated) return [];
    return [];
  }
}
