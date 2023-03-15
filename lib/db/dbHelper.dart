import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/gratitude.dart';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(join(await getDatabasesPath(), 'gratitude_notes.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
    return _db;
  }

  static void _createDb(Database db) {
    db.execute(
      "CREATE TABLE Gratitude(id INTEGER PRIMARY KEY, note TEXT, resolution TEXT)",
    );
  }

  Future<void> insertItem(Gratitude gratitude) async {
    final db = await database;
    await db.insert("Gratitude", gratitude.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Gratitude>> selectAllItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = (await db.query('Gratitude'));
    return List.generate(maps.length, (index) => Gratitude(
        id: maps[index]['id'],
        note: maps[index]['note'],
        resolution: maps[index]['resolution']
    ));
  }

  Future<List<int>> selectAllIds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = (await db.rawQuery('SELECT id FROM Gratitude'));
    return List.generate(maps.length, (index) => maps[index]['id']);
  }


  Future<int?> selectAllCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM Gratitude');
    final count = Sqflite.firstIntValue(result);
    return count;
  }

  Future<Gratitude> selectItem(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = (await db.query(
      'Gratitude',
      where: 'id = ?',
      whereArgs: [id],
    ));
    return Gratitude(
        id: maps[0]['id'],
        note: maps[0]['note'],
        resolution: maps[0]['resolution']
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      "Gratitude",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllItem() async {
    final db = await database;
    await db.delete("Gratitude");
  }

}