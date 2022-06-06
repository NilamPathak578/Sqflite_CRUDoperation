import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static const databasename = "persons.db";
  static const dbversion = 1;
  static const tablename = "my_table";
  static const columnId = "ID";
  static const columnname = "name";
  static const columnage = "age";

  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, databasename);
    return await openDatabase(path,
        version: dbversion, onCreate: _onCreateDatabase);
  }

  Future _onCreateDatabase(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tablename($columnId integer primary key,
$columnname TEXT NOT NULL,
$columnage INTEGER NOT NULL)
''');
  }

  //function to create, insert,update and delete query
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tablename, row);
  }

  //query all rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database? db = await instance.database;
    return await db!.query(tablename);
  }

  //query to specific data
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database? db = await instance.database;
    //var res = await db!.query(tablename, where: "age < ?", whereArgs: [age]);
    var res = await db!.rawQuery('SELECT * from table where age>?', [age]);
    return res;
  }

  //query to delete data
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    var res = await db!.delete(tablename, where: 'id=?', whereArgs: [id]);
    return res;
  }

  //query to update data
  Future<int> update(int id) async {
    Database? db = await instance.database;
    var res = await db!.update(tablename, {"name": "Nilam", "age": "25"},
        where: "id=?", whereArgs: [id]);
    return res;
  }
}
