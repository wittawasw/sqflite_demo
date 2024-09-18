import 'package:sqflite_demo/src/provinces/service.dart';

class ProvincesController {
  final _service = ProvincesService();

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items => _items;

  Future<void> loadItems() async {
    _items = await _service.getItems();
  }
}
