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
        title: const Text('Provinces'),
      ),
      body: _controller.items.isEmpty
          ? const Center(child: Text('No Provinces found.'))
          : ListView.builder(
              itemCount: _controller.items.length,
              itemBuilder: (context, index) {
                final item = _controller.items[index];
                print(item);
                print(item);
                print(item);
                print(item);

                return ListTile(
                  title: Text(item['name_th']),
                  subtitle: Text(item['name_en']),
                  trailing: Text(item['code']),
                );
              },
            ),
    );
  }
}
