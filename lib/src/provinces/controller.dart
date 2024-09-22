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
    if (!hasMoreItems) return;

    if (_isNewSearch(q)) {
      _resetForNewSearch(q);
    }

    await _fetchAndAddItems();
  }

  bool _isNewSearch(String? q) {
    return currentQuery != q;
  }

  void _resetForNewSearch(String? q) {
    currentPage = 1;
    hasMoreItems = true;
    _items.clear();
    currentQuery = q;
  }

  Future<void> _fetchAndAddItems() async {
    final newItems = await _service.getItems(
        page: currentPage, perPage: 10, q: currentQuery);

    if (newItems.isEmpty) {
      hasMoreItems = false;
    } else {
      _items.addAll(newItems);
      currentPage++;
    }

    // Simulate Delay (Check if indicator is working as intend)
    await Future.delayed(const Duration(seconds: 3));

    isLoading = false;
  }

  void clearItems() {
    _items = [];
  }
}
