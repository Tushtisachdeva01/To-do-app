import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var database = await openDatabase(join(directory.path, "todo_db"),
        version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY,name TEXT,desc TEXT)");
  }
}
