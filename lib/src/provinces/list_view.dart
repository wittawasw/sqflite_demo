import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/provinces/controller.dart';
import 'package:sqflite_demo/src/provinces/widgets/list.dart';

class ProvincesListView extends StatefulWidget {
  const ProvincesListView({super.key});

  static const routeName = '/provinces';

  @override
  State<ProvincesListView> createState() => _ProvincesListViewState();
}

class _ProvincesListViewState extends State<ProvincesListView> {
  final ProvincesController _controller = ProvincesController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_controller.isLoading &&
          _controller.hasMoreItems) {
        _loadItems(loadMore: true);
      }
    });
  }

  Future<void> _loadItems({bool loadMore = false}) async {
    setState(() {
      _controller.isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    await _controller.loadItems(
        loadMore: loadMore, q: _searchTextController.text);

    setState(() {
      _controller.isLoading = false;
    });
  }

  Future<void> _search() async {
    setState(() {
      _controller.clearItems();
      _controller.hasMoreItems = true;
      _controller.isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    await _loadItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provinces'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchTextController,
                    decoration: const InputDecoration(
                      labelText: 'Search Provinces',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _search();
                  },
                ),
              ],
            ),
          ),
          ProvincesList(
            controller: _controller,
            scrollController: _scrollController,
          ),
        ],
      ),
    );
  }
}
