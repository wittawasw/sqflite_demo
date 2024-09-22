import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/provinces/controller.dart';

class ProvincesList extends StatelessWidget {
  final ProvincesController controller;
  final ScrollController scrollController;

  const ProvincesList({
    super.key,
    required this.controller,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: controller.items.isEmpty && !controller.isLoading
          ? const Center(child: Text('No Provinces found.'))
          : ListView.builder(
              controller: scrollController,
              itemCount: controller.items.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.items.length) {
                  return _loadingIndicator();
                }

                final item = controller.items[index];
                return ListTile(
                  title: Text(item.nameTH),
                  subtitle: Text(item.nameEN),
                  trailing: Text(item.code),
                );
              },
            ),
    );
  }

  Widget _loadingIndicator() {
    return controller.isLoading
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          )
        : const SizedBox.shrink();
  }
}
