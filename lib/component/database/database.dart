import "dart:io";

import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

class DatabaseManager {
  DatabaseManager._private();

  static DatabaseManager instance = DatabaseManager._private();
  Database? _db;

  Future<Database> get db async {
    // ignore: prefer_conditional_assignment
    if (_db == null) {
      _db = await _initDB();
    }

    return _db!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();

    String path = join(docDir.path, "profile.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        return await database.execute('''
            CREATE TABLE profile (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              name TEXT NOT NULL,
              phoneNumber TEXT NOT NULL,
              email TEXT NOT NULL,
              imagePath TEXT NOT NULL
            )
          ''');
      },
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
