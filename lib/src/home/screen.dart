import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/provinces/list_view.dart';
import 'package:sqflite_demo/src/sample_items/list_view.dart';
import 'package:sqflite_demo/src/settings/settings_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Navigate to the settings page. If the user leaves and returns
            // to the app after it has been killed while running in the
            // background, the navigation stack is restored.
            Navigator.restorablePushNamed(context, SettingsView.routeName);
          },
        ),
      ]),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Sample Items'),
            subtitle: const Text('Example of CRUD'),
            onTap: () {
              Navigator.pushNamed(context, SampleItemListView.routeName);
            },
          ),
          ListTile(
            title: const Text('Sample DB'),
            subtitle: const Text('Example of items from DB'),
            onTap: () {
              Navigator.pushNamed(context, ProvincesListView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
