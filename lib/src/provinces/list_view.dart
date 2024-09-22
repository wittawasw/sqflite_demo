import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/provinces/controller.dart';

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
          !_controller.isLoading) {
        _loadItems(loadMore: true); // Load more items when scrolled to bottom
      }
    });
  }

  Future<void> _search() async {
    _controller.hasMoreItems = true;
    setState(() {});

    _loadItems();
  }

  Future<void> _loadItems({bool loadMore = false}) async {
    await _controller.loadItems(
        loadMore: loadMore, q: _searchTextController.text);
    setState(() {});
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
          Expanded(
            child: _controller.items.isEmpty && !_controller.isLoading
                ? const Center(child: Text('No Provinces found.'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _controller.items.length) {
                        return _loadingIndicator();
                      }

                      final item = _controller.items[index];
                      return ListTile(
                        title: Text(item.nameTH),
                        subtitle: Text(item.nameEN),
                        trailing: Text(item.code),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _loadingIndicator() {
    return _controller.isLoading
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          )
        : const SizedBox.shrink();
  }
}
