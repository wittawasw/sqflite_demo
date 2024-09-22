import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/src/database/database_service.dart';
import 'package:sqflite_demo/src/models/province.dart';

class ProvincesService {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await DatabaseService.loadDatabase();
    return _db!;
  }

  Future<List<Province>> getItems({
    String? q,
    int page = 1,
    int perPage = 10,
  }) async {
    final db = await database;
    final offset = _calculateOffset(page, perPage);

    final queryData = _buildWhereClause(q);

    final result = await db.rawQuery(
      '''
      SELECT * FROM provinces
      ${queryData['whereClause']}
      LIMIT ? OFFSET ?
      ''',
      [...queryData['whereArgs'], perPage, offset],
    );

    return _mapResultToProvince(result);
  }

  int _calculateOffset(int page, int perPage) {
    return (page - 1) * perPage;
  }

  Map<String, dynamic> _buildWhereClause(String? q) {
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (q != null && q.isNotEmpty) {
      whereClause = 'WHERE name_th LIKE ? OR name_en LIKE ?';
      whereArgs = ['%$q%', '%$q%'];
    }

    return {
      'whereClause': whereClause,
      'whereArgs': whereArgs,
    };
  }

  List<Province> _mapResultToProvince(List<Map<String, dynamic>> result) {
    return result.map((item) => Province.fromJson(item)).toList();
  }
}
