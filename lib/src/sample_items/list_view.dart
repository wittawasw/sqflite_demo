import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/models/sample_item.dart';
import 'package:sqflite_demo/src/sample_items/controller.dart';
import 'package:sqflite_demo/src/sample_items/details_view.dart';
import 'package:sqflite_demo/src/sample_items/new_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({super.key});

  static const routeName = '/sample_items';

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
                  return sampleItemTile(_controller.items[index]);
                },
              ),
        floatingActionButton: newSampleItemBtn());
  }

  Widget sampleItemTile(SampleItem item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.description),
      trailing: Text(item.price.toString()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SampleItemDetailsView(id: item.id, onDelete: _loadItems),
          ),
        ).then((_) {
          _loadItems();
        });
      },
    );
  }

  Widget newSampleItemBtn() {
    return FloatingActionButton(
      onPressed: () async {
        final newItem = await Navigator.push<SampleItem>(
          context,
          MaterialPageRoute(
            builder: (context) => const SampleItemNewView(),
          ),
        );

        if (newItem != null) {
          await _controller.addItem(newItem);
          _loadItems();
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
