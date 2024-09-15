import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item_controller.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({super.key});

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final SampleItemController _controller = SampleItemController();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    await _controller.loadItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
      ),
      body: _controller.items.isEmpty
          ? const Center(child: Text('No items found.'))
          : ListView.builder(
              itemCount: _controller.items.length,
              itemBuilder: (context, index) {
                final item = _controller.items[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(item['description']),
                  trailing: Text(item['price'].toString()),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _controller.addItem({
            'id': DateTime.now().millisecondsSinceEpoch,
            'name': 'New Item',
            'description': 'Sample description',
            'price': 1,
          });
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
