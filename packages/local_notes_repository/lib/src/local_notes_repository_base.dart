import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class LocalNotesRepository {
  LocalNotesRepository({required this.onDbInitialized}) {
    initDB();
  }

  Function onDbInitialized;

  late Database _database;

  Future<void> initDB() async {
    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        "notes_databased.b",
      ),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE notes(title STRING, dateCreated BIGINT, content STRING)');
      },
      version: 1,
    );
    onDbInitialized();
  }

  Future<void> createNote(Note note) async {
    _database.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getNotes() async {
    var maps = await _database.query('notes');
    return List.generate(
      maps.length,
      (index) => Note.fromMap(maps[index]),
    );
  }
}
