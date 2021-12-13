import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vetmanager_admission_creator/Model/Db/Credentials.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  String credentialsTable = 'Credentials';
  String columnId = 'id';
  String columnApiHost = 'apiHost';
  String columnApiToken = 'apiToken';

  Future<Database> get database async {
    //if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Credentials.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $credentialsTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnApiHost TEXT, $columnApiToken TEXT)',
    );
  }

  // READ
  Future<List<Credentials>> getCredentials() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> credentialsMapList =
    await db.query(credentialsTable);
    final List<Credentials> credentialsList = [];
    credentialsMapList.forEach((studentMap) {
      credentialsList.add(Credentials.fromMap(studentMap));
    });

    return credentialsList;
  }

  // INSERT
  Future<Credentials> insertCredentials(Credentials credentials) async {
    Database db = await this.database;
    credentials.id = await db.insert(credentialsTable, credentials.toMap());
    return credentials;
  }

  // UPDATE
  Future<int> updateCredentials(Credentials credentials) async {
    Database db = await this.database;
    return await db.update(
      credentialsTable,
      credentials.toMap(),
      where: '$columnId = ?',
      whereArgs: [credentials.id],
    );
  }

  // DELETE
  Future<int> deleteCredentials(int? id) async {
    Database db = await this.database;
    return await db.delete(
      credentialsTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
