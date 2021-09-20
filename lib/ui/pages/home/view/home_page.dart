import 'package:flutter/material.dart';
import 'package:local_notes_repository/local_notes_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> notes = [];

  late LocalNotesRepository repo;

  void onDbInitialized() {
    init();
    setState(() {
      dbIsInitialized = true;
    });
  }

  bool dbIsInitialized = false;

  @override
  void initState() {
    repo = LocalNotesRepository(onDbInitialized: onDbInitialized);
    super.initState();
  }

  Future<void> init() async {
    notes = await repo.getNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: dbIsInitialized
          ? ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) =>
                  Text("note: ${notes[index].title}"),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
