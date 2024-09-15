import 'package:flutter/material.dart';

class SampleItemForm extends StatefulWidget {
  final Map<String, dynamic> sampleItem;
  final Function(Map<String, dynamic>)? onSubmit;

  const SampleItemForm({
    super.key,
    required this.sampleItem,
    this.onSubmit,
  });

  @override
  State<SampleItemForm> createState() => _SampleItemFormState();
}

class _SampleItemFormState extends State<SampleItemForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late int _price;

  @override
  void initState() {
    super.initState();
    _name = widget.sampleItem['name'] ?? '';
    _description = widget.sampleItem['description'] ?? '';
    _price = widget.sampleItem['price']?.toInt() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: _name,
            decoration: const InputDecoration(labelText: 'Name'),
            onSaved: (value) => _name = value ?? '',
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter a name' : null,
          ),
          TextFormField(
            initialValue: _description,
            decoration: const InputDecoration(labelText: 'Description'),
            onSaved: (value) => _description = value ?? '',
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter a description' : null,
          ),
          TextFormField(
            initialValue: _price.toString(),
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            onSaved: (value) => _price = int.tryParse(value ?? '0') ?? 0,
            validator: (value) =>
                value == null || double.tryParse(value) == null
                    ? 'Enter a valid price'
                    : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                final savedItem = {
                  'id': widget.sampleItem['id'] ??
                      DateTime.now().millisecondsSinceEpoch,
                  'name': _name,
                  'description': _description,
                  'price': _price,
                };

                if (widget.onSubmit != null) {
                  widget.onSubmit!(savedItem);
                }

                Navigator.pop(context, savedItem);
              }
            },
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
