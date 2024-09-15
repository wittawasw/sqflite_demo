import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item_controller.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatefulWidget {
  final int id;
  const SampleItemDetailsView({super.key, required this.id});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: item == null
            ? const Text('Loading...')
            : Text('ID: ${item!['id']} - ${item!['name']}'),
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
