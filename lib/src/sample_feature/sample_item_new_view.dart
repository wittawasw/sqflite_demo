import 'package:flutter/material.dart';
import 'sample_item_form.dart';

class SampleItemNewView extends StatelessWidget {
  const SampleItemNewView({super.key});

  static const routeName = '/sample_item/new';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> newSampleItem = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': '',
      'description': '',
      'price': 0.0,
    };

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
