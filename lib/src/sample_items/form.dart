import 'package:flutter/material.dart';
import 'package:sqflite_demo/src/models/sample_item.dart';

class SampleItemForm extends StatefulWidget {
  final SampleItem sampleItem;
  final Function(Map<String, dynamic>)? onSubmit;
  final String submitText;

  const SampleItemForm({
    super.key,
    required this.sampleItem,
    this.onSubmit,
    String? submitText,
  }) : submitText = submitText ?? 'Submit';

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
    _name = widget.sampleItem.name;
    _description = widget.sampleItem.description;
    _price = widget.sampleItem.price;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          nameInput(),
          descriptionInput(),
          priceInput(),
          const SizedBox(height: 20),
          submitBtn(),
        ],
      ),
    );
  }

  Widget nameInput() {
    return TextFormField(
      initialValue: _name,
      decoration: const InputDecoration(labelText: 'Name'),
      onSaved: (value) => _name = value ?? '',
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter a name' : null,
    );
  }

  Widget descriptionInput() {
    return TextFormField(
      initialValue: _description,
      decoration: const InputDecoration(labelText: 'Description'),
      onSaved: (value) => _description = value ?? '',
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter a description' : null,
    );
  }

  Widget priceInput() {
    return TextFormField(
      initialValue: _price.toString(),
      decoration: const InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      onSaved: (value) => _price = int.tryParse(value ?? '0') ?? 0,
      validator: (value) => value == null || double.tryParse(value) == null
          ? 'Enter a valid price'
          : null,
    );
  }

  Widget submitBtn() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          final savedItem = {
            'id': widget.sampleItem.id,
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
      child: Text(widget.submitText),
    );
  }
}
