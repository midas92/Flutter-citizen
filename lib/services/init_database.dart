import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'red_squirrel.db');

  // Pass the existing database instance if it is already open
  final database = await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS quizzes (id INTEGER PRIMARY KEY AUTOINCREMENT, question TEXT, option_a TEXT, option_b TEXT, option_c TEXT, option_d TEXT, answer_a TEXT, answer_b TEXT, feedback TEXT, chapter INTEGER, type INTEGER)');

      await db.execute(
          'CREATE TABLE IF NOT EXISTS marks (id INTEGER PRIMARY KEY AUTOINCREMENT, chapter INTEGER, correct INTEGER, total INTEGER, timestamp INTEGER)');
    },
    version: 1,
  );
  return database;
}
