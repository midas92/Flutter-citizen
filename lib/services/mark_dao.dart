import 'package:red_squirrel/services/init_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:red_squirrel/utils/constants/classes.dart';

class MarkDao {
  // A method that inserts mark into the database
  static Future<void> insertMark(Mark mark) async {
    final db = await createDatabase();

    await db.insert(
      'marks',
      mark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves latest mark from the marks table.
  static Future<Mark> getChapterMark(int chapter) async {
    // Get a reference to the database.
    final db = await createDatabase();
    final List<Map<String, dynamic>> maps;
    maps = await db.query(
      'marks',
      where: 'chapter = ?',
      whereArgs: [chapter],
      orderBy: 'timestamp DESC',
      limit: 1,
    );
    if (maps.isEmpty) {
      return Mark(
        id: 0,
        chapter: chapter,
        correct: 0,
        total: 0,
        timestamp: 0,
      );
    } else {
      return Mark(
        id: maps[0]['id'],
        chapter: maps[0]['chapter'],
        correct: maps[0]['correct'],
        total: maps[0]['total'],
        timestamp: maps[0]['timestamp'],
      );
    }
  }
}
