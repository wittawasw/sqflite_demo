import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/src/database/database_service.dart';

class ProvincesService {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await DatabaseService.loadDatabase();
    return _db!;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;

    return await db.query('provinces');
  }
}
