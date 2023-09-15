import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static late Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('planner.db');
    return _database;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, dueDate TEXT, priority TEXT)',
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        dueDate: maps[i]['dueDate'],
        priority: maps[i]['priority'],
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Task {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final String priority;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
    };
  }
}
