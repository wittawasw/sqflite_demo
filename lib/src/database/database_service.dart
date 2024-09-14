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
          'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      version: 1,
    );
  }

  // CRUD methods
  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    await db.insert('items', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await getDatabase();
    return await db.query('items');
  }

  Future<void> updateItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    await db.update(
      'items',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await getDatabase();
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
