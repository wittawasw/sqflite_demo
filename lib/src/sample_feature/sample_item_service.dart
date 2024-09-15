import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/src/database/database_service.dart';

class SampleItemService {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await DatabaseService.getDatabase();
    return _db!;
  }

  Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await database;

    await db.insert('sample_items', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;

    return await db.query('sample_items');
  }

  Future<void> updateItem(Map<String, dynamic> item) async {
    final db = await database;

    await db.update(
      'sample_items',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;

    await db.delete(
      'sample_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
