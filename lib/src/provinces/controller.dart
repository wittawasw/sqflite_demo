import 'package:sqflite_demo/src/models/province.dart';
import 'package:sqflite_demo/src/provinces/service.dart';

class ProvincesController {
  final _service = ProvincesService();

  // ignore: prefer_final_fields, have to add this to shut warning up.
  List<Province> _items = [];
  List<Province> get items => _items;

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreItems = true;

  // Future<void> loadItems() async {
  //   _items = await _service.getItems();
  // }
  Future<void> loadItems({bool loadMore = false}) async {
    if (isLoading || !hasMoreItems) return;

    isLoading = true;

    if (!loadMore) {
      currentPage = 1;
      _items.clear();
    }

    final newItems = await _service.getItems(page: currentPage, perPage: 10);

    if (newItems.isEmpty) {
      hasMoreItems = false;
    } else {
      _items.addAll(newItems);
      currentPage++;
    }

    isLoading = false;
  }
}
