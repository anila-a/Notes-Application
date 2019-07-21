import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_app/models/note.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = 'note_table';
  String idCol = 'id';
  String titleCol = 'title';
  String descriptionCol = 'description';
  String dateCol = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // executed only once
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // open the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($idCol INTEGER PRIMARY KEY AUTOINCREMENT, $titleCol TEXT, '
        '$descriptionCol TEXT, $dateCol TEXT)');
  }

  // Get objects from database - Fetch operation
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $noteTable');

    return result;
  }

  // Insert objects to database - Insert operation
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());

    return result;
  }

  // Update objects and save to database - Update operation
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$idCol = ?', whereArgs: [note.id]);

    return result;
  }

  // Delete objects from database - Delete operation
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $idCol = $id');

    return result;
  }

  // Count number of objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');

    int result = Sqflite.firstIntValue(x);

    return result;
  }

  // Convert Map List into Note List
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int cnt = noteMapList.length;

    List<Note> noteList = List<Note>();
    for (int i = 0; i < cnt; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
