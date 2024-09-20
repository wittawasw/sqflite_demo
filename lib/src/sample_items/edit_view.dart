import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/models/sample_item.dart';
import 'package:sqflite_demo/src/sample_items/controller.dart';
import 'package:sqflite_demo/src/sample_items/form.dart';

class SampleItemEditView extends StatelessWidget {
  final SampleItem item;

  const SampleItemEditView({super.key, required this.item});

  static const routeName = '/sample_items/edit';

  @override
  Widget build(BuildContext context) {
    final SampleItemController controller = SampleItemController();

    void handleSubmit(Map<String, dynamic> updatedItem) async {
      await controller.updateItem(SampleItem.fromJson(updatedItem));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SampleItemForm(
          sampleItem: item,
          onSubmit: handleSubmit,
          submitText: 'Update',
        ),
      ),
    );
  }
}
