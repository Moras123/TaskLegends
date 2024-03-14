import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'tasks';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, date TEXT, status TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTask(String task) async {
    final db = await database;
    await db.insert(
      tableName,
      {'task': task, 'date': DateTime.now().toString(), 'status': 'Pendiente'},
    );
  }

  static Future<void> updateTask(int id, String newTask) async {
    final db = await database;
    await db.update(
      tableName,
      {'task': newTask},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
