import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/gratitude.dart';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(join(await getDatabasesPath(), 'gratitude.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
    return _db;
  }

  static void _createDb(Database db) {
    db.execute(
      "CREATE TABLE Gratitude(id INTEGER PRIMARY KEY, note TEXT)",
    );
  }

  Future<void> insertGratitude(Gratitude gratitude) async {
    final db = await database;

    await db.insert("Gratitude", gratitude.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<Gratitude> selectGratitude(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = (await db.query(
      'Gratitude',
      where: 'id = ?',
      whereArgs: [id],
    ));

    return Gratitude(
        id: maps[0]['id'],
        note: maps[0]['note']
    );
  }

  Future<void> deleteGratitude(int id) async {
    final db = await database;

    await db.delete(
      "Gratitude",
      where: "id = ?",
      whereArgs: [id],
    );
  }

}