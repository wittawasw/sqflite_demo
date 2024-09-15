import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item_controller.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatefulWidget {
  final int id;
  final VoidCallback? onDelete;
  const SampleItemDetailsView({super.key, required this.id, this.onDelete});

  static const routeName = '/sample_item';

  @override
  State<SampleItemDetailsView> createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  final SampleItemController _controller = SampleItemController();
  Map<String, dynamic>? item;

  @override
  void initState() {
    super.initState();
    _loadItemDetails();
  }

  Future<void> _loadItemDetails() async {
    await _controller.loadItems();
    setState(() {
      item = _controller.items.firstWhere((item) => item['id'] == widget.id);
    });
  }

  Future<void> _deleteItem() async {
    await _controller.deleteItem(widget.id);
    if (widget.onDelete != null) {
      widget.onDelete!();
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: item == null
            ? const Text('Loading...')
            : Text('ID: ${item!['id']} - ${item!['name']}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: item == null
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Item'),
                          content: const Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Cancel delete
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                _deleteItem(); // Delete the item
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
          ),
        ],
      ),
      body: item == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${item!['name']}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  Text('Description: ${item!['description']}'),
                  const SizedBox(height: 8),
                  Text('Price: ${item!['price']}'),
                ],
              ),
            ),
    );
  }
}
