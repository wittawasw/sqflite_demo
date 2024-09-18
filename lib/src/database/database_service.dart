import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
            CREATE TABLE sample_items(
              id INTEGER PRIMARY KEY,
              name TEXT,
              description TEXT,
              price INTEGER
            )
          ''',
        );
      },
      version: 1,
    );
  }

  static Future<Database> loadDatabase() async {
    String dbPath = join(await getDatabasesPath(), 'tambons.db');

    bool exists = await databaseExists(dbPath);

    if (!exists) {
      ByteData data = await rootBundle.load('assets/tambons.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dbPath).writeAsBytes(bytes);
    }

    return openDatabase(dbPath);
  }
}
