import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _habitTableName = "habit";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openNewDatabase();
    return _db!;
  }

  Future<Database> openNewDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "habit.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_habitTableName (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            completionId INTEGER DEFAULT 2,
            type TEXT NOT NULL,
            createdAt DATE DEFAULT NOW
          )
        ''');
      },
    );

    return database;
  }

  void addHabit(String title, String habitType) async {
    final db = await database;
    final value = {
      "title": title,
      "type": "task",
    };
    await db.insert(_habitTableName, value);
  }

  void printHabit() async {
    final db = await database;
    final list = await db.rawQuery("SELECT title, type FROM habit");
    print(list);
  }
}
