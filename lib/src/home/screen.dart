import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Sample Items'),
            subtitle: const Text('Example of CRUD'),
            onTap: () {
              Navigator.pushNamed(context, SampleItemListView.routeName);
            },
          ),
          const ListTile(
            title: Text('Sample DB'),
            subtitle: Text('Example of items from DB'),
          ),
        ],
      ),
    );
  }
}
