import 'package:sqflite_demo/src/provinces/province.dart';
import 'package:sqflite_demo/src/provinces/service.dart';

class ProvincesController {
  final _service = ProvincesService();

  List<Province> _items = [];
  List<Province> get items => _items;

  Future<void> loadItems() async {
    _items = await _service.getItems();
  }
}
