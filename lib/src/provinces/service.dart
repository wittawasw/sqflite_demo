import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/src/database/database_service.dart';
import 'package:sqflite_demo/src/models/province.dart';

class ProvincesService {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await DatabaseService.loadDatabase();
    return _db!;
  }

  // Future<List<Province>> getItems() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> result = await db.query('provinces');

  //   return result.map((item) => Province.fromJson(item)).toList();
  // }
  Future<List<Province>> getItems(
      {String? q, int page = 1, int perPage = 10}) async {
    final db = await database;
    final offset = (page - 1) * perPage;

    String whereClause = '';
    List<dynamic> whereArgs = [];
    if (q != null && q.isNotEmpty) {
      whereClause = 'WHERE name_th LIKE ? OR name_en LIKE ?';
      whereArgs = ['%$q%', '%$q%'];
    }

    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT * FROM provinces
    $whereClause
    LIMIT ? OFFSET ?
    ''',
      [...whereArgs, perPage, offset],
    );

    return result.map((item) => Province.fromJson(item)).toList();
  }
}
