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
}
