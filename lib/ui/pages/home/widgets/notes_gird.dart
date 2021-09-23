import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/ui/pages/home/bloc/home_bloc.dart';

import 'note_tile.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    Key? key,
    required this.state,
  }) : super(key: key);

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      itemCount: state.notes.length,
      crossAxisCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: NoteTile(
          state: state,
          note: state.notes[index],
        ),
      ),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    );
  }
}
