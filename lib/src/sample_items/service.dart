import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/src/database/database_service.dart';
import 'package:sqflite_demo/src/models/sample_item.dart';

class SampleItemService {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await DatabaseService.getDatabase();
    return _db!;
  }

  Future<void> insertItem(SampleItem item) async {
    final db = await database;

    await db.insert('sample_items', item.toJson());
  }

  Future<List<SampleItem>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('sample_items');

    return result.map((item) => SampleItem.fromJson(item)).toList();
  }

  Future<void> updateItem(SampleItem item) async {
    final db = await database;

    await db.update(
      'sample_items',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
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
