import 'package:sqflite/sqflite.dart';
import 'package:todo/repositories/database.dart';

class Repository {
  DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;
  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table, data) async {
    var connection = await db;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await db;
    return await connection.query(table);
  }

  readDataById(table, categoryId) async {
    var connection = await db;
    return await connection
        .query(table, where: 'id=?', whereArgs: [categoryId]);
  }

  updateData(table, data) async {
    var connection = await db;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table,id) async{
    var connection = await db;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $id");
  }
}
