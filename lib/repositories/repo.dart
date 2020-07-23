import 'package:sqflite/sqflite.dart';
import 'package:todo/repositories/database.dart';

class Repository{
  DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;
  Future<Database> get db async{
    if(_database != null)
    return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }
  insertData(table,data) async{
    var connection = await db;
    return await connection.insert(table, data);
  }
  readData(table)async{
    var connection = await db;
    return await connection.query(table);
  }
}