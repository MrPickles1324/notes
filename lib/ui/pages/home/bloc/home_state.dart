part of 'home_bloc.dart';

enum NotesStatus {
  loading,
  ready,
  empty,
}

class HomeState {
  final List<Note> notes;
  final NotesStatus notesStatus;
  HomeState({
    required this.notes,
    required this.notesStatus,
  });

  HomeState copyWith({
    List<Note>? notes,
    NotesStatus? notesStatus,
  }) {
    return HomeState(
      notes: notes ?? this.notes,
      notesStatus: notesStatus ?? this.notesStatus,
    );
  }
}
