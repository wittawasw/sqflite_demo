import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item.dart';
import 'package:sqflite_demo/src/sample_feature/sample_item_form.dart';

class SampleItemNewView extends StatelessWidget {
  const SampleItemNewView({super.key});

  static const routeName = '/sample_items/new';

  @override
  Widget build(BuildContext context) {
    final SampleItem newSampleItem = SampleItem.initialize();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            SampleItemForm(sampleItem: newSampleItem, submitText: 'Add Item'),
      ),
    );
  }
}
