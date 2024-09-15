import 'package:sqflite_demo/src/sample_feature/sample_item_service.dart';

class SampleItemController {
  final _service = SampleItemService();

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> get items => _items;

  Future<void> loadItems() async {
    _items = await _service.getItems();
  }

  Future<void> addItem(Map<String, dynamic> item) async {
    await _service.insertItem(item);
  }

  Future<void> updateItem(Map<String, dynamic> item) async {
    await _service.updateItem(item);
  }

  Future<void> deleteItem(int id) async {
    await _service.deleteItem(id);
  }
}
