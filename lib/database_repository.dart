import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import 'model.dart';
import 'const.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  late Database _database;
  
  Future<Database> initDatabase() async {
    sqfliteFfiInit(); // Inicialize o FFI
    databaseFactory = databaseFactoryFfi; // Use a fábrica de banco de dados FFI

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');

    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
create table ${AppConst.tableName} ( 
  ${AppConst.id} integer primary key autoincrement, 
  ${AppConst.title} text not null,
  ${AppConst.describtion} text not null,
  ${AppConst.isImportant} boolean not null)
''');
  }

  Future<void> insert({required ToDoModel todo}) async {
    try {
      final db = await initDatabase(); // Inicialize o banco de dados
      await db.insert(AppConst.tableName, todo.toMap());
      print('todoAdded');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<ToDoModel>> getAllTodos() async {
    final db = await initDatabase(); // Inicialize o banco de dados

    final result = await db.query(AppConst.tableName);

    return result.map((json) => ToDoModel.fromJson(json)).toList();
  }

  Future<void> delete(int id) async {
    try {
      final db = await initDatabase(); // Inicialize o banco de dados
      await db.delete(
        AppConst.tableName,
        where: '${AppConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(ToDoModel todo) async {
    try {
      final db = await initDatabase(); // Inicialize o banco de dados
      db.update(
        AppConst.tableName,
        todo.toMap(),
        where: '${AppConst.id} = ?',
        whereArgs: [todo.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
