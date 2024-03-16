import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'tasks';
  static const String deletedTableName = 'deleted_tasks';


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
        db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, date TEXT, status TEXT)',
        );
        // Crear nueva tabla para tareas eliminadas
        db.execute(
          'CREATE TABLE deleted_tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, date TEXT, status TEXT)',
        );
      },
      version: 1,
    );
  }
  static Future<void> modifyTask(String name, String newName) async {
    final db = await database;
    await db.update(
      tableName,
      {'task': newName},
      where: 'task = ?',
      whereArgs: [name],
    );
  }
  static Future<void> insertTask(String task) async {
    final db = await database;
    await db.insert(
      tableName,
      {'task': task, 'date': DateTime.now().toString(), 'status': 'Pendiente'},
    );
  }

  static Future<void> insertTaskDelete(String task) async {
    final db = await database;
    await db.insert(
      deletedTableName,
      {'task': task, 'date': DateTime.now().toString(), 'status': 'Completado'},
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
  static Future<List<Map<String, dynamic>>> readTable() async {
    final db = await database;
    return db.query(tableName);
  }

  static Future<List<Map<String, dynamic>>> readDeletedTasks() async {
    final db = await database;
    return db.query('deleted_tasks');
  }

  static Future<void> deleteTask(String name) async {
    final db = await database;
    insertTaskDelete(name);
    await db.delete(
      tableName,
      where: 'task = ?',
      whereArgs: [name],
    );
  }



  static Future<void> deleteTask_addDelete(String name) async {
    final db = await database;

    // Primero, obtener la tarea a eliminar
    final taskToDelete = await db.query(
      tableName,
      where: 'task = ?',
      whereArgs: [name],
    );

    if (taskToDelete.isNotEmpty) {
      // Insertar la tarea en deleted_tasks
      await db.insert('tareasd', taskToDelete.first);

      // Luego, eliminar la tarea de tasks
    }
    await db.delete(
      tableName,
      where: 'task = ?',
      whereArgs: [name],
    );
  }
}