import 'package:sqflite_demo/src/sample_feature/sample_item.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item_service.dart';

class SampleItemController {
  final _service = SampleItemService();

  List<SampleItem> _items = [];
  List<SampleItem> get items => _items;

  Future<void> loadItems() async {
    _items = await _service.getItems();
  }

  Future<void> addItem(SampleItem item) async {
    await _service.insertItem(item);
  }

  Future<void> updateItem(SampleItem item) async {
    await _service.updateItem(item);
  }

  Future<void> deleteItem(int id) async {
    await _service.deleteItem(id);
  }
}
