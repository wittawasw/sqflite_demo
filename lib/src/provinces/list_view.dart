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

  Future<void> _loadItems({bool loadMore = false}) async {
    await _controller.loadItems(loadMore: loadMore);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provinces'),
      ),
      body: _controller.items.isEmpty
          ? const Center(child: Text('No Provinces found.'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: _controller.items.length + 1,
              itemBuilder: (context, index) {
                if (index == _controller.items.length) {
                  return _controller.hasMoreItems
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }

                final item = _controller.items[index];
                return ListTile(
                  title: Text(item.nameTH),
                  subtitle: Text(item.nameEN),
                  trailing: Text(item.code),
                );
              },
            ),
    );
  }
}
