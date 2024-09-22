import 'package:sqflite_demo/src/models/province.dart';
import 'package:sqflite_demo/src/provinces/service.dart';

class ProvincesController {
  final _service = ProvincesService();

  List<Province> _items = [];
  List<Province> get items => _items;

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreItems = true;
  String? currentQuery;

  Future<void> loadItems({bool loadMore = false, String? q}) async {
    bool isNewSearch = currentQuery != q;

    if (isNewSearch) {
      currentPage = 1;
      hasMoreItems = true;
      _items.clear();
      currentQuery = q;
    }

    isLoading = true;

    final newItems =
        await _service.getItems(page: currentPage, perPage: 10, q: q);

    if (newItems.isEmpty) {
      hasMoreItems = false;
    } else {
      _items.addAll(newItems);
      currentPage++;
    }

    isLoading = false;
    await Future.delayed(const Duration(seconds: 3));
  }
}
