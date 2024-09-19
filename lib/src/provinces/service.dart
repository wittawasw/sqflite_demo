import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/src/database/database_service.dart';
import 'package:sqflite_demo/src/provinces/province.dart';

class ProvincesService {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await DatabaseService.loadDatabase();
    return _db!;
  }

  Future<List<Province>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('provinces');

    return result.map((item) => Province.fromJson(item)).toList();
  }
}
