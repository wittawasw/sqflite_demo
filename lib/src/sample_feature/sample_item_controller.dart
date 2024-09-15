import 'package:flutter/material.dart';
import '../database/database_service.dart';

class SampleItemController with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  Future<void> loadItems() async {
    _items = await DatabaseService().getItems();
    notifyListeners();
  }

  Future<void> addItem(Map<String, dynamic> item) async {
    await DatabaseService().insertItem(item);
    loadItems();
  }

  Future<void> updateItem(Map<String, dynamic> item) async {
    await DatabaseService().updateItem(item);
    loadItems();
  }

  Future<void> deleteItem(int id) async {
    await DatabaseService().deleteItem(id);
    loadItems();
  }
}
