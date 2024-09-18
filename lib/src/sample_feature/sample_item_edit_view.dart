import 'package:flutter/material.dart';
import 'sample_item_form.dart';
import 'sample_item_controller.dart';

class SampleItemEditView extends StatelessWidget {
  final Map<String, dynamic> item;

  const SampleItemEditView({super.key, required this.item});

  static const routeName = '/sample_items/edit';

  @override
  Widget build(BuildContext context) {
    final SampleItemController controller = SampleItemController();

    void handleSubmit(Map<String, dynamic> updatedItem) async {
      await controller.updateItem(updatedItem);
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
