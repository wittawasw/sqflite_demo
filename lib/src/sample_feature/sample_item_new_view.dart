import 'package:flutter/material.dart';

class SampleItemNewView extends StatefulWidget {
  const SampleItemNewView({super.key});

  static const routeName = '/sample_item/new';

  @override
  State<SampleItemNewView> createState() => _SampleItemNewViewState();
}

class _SampleItemNewViewState extends State<SampleItemNewView> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  double _price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter a description'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.tryParse(value ?? '0') ?? 0,
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

                    final newItem = {
                      'id': DateTime.now().millisecondsSinceEpoch,
                      'name': _name,
                      'description': _description,
                      'price': _price,
                    };

                    Navigator.pop(context, newItem);
                  }
                },
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
