import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/resourcemodel.dart';

class EditResourcePage extends StatefulWidget {
  final Resource resource;

  EditResourcePage({required this.resource});

  @override
  _EditResourcePageState createState() => _EditResourcePageState();
}

class _EditResourcePageState extends State<EditResourcePage> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late String _url;

  @override
  void initState() {
    super.initState();
    _title = widget.resource.title;
    _description = widget.resource.description;
    _url = widget.resource.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Edit Resource'),
    ),
    body: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    TextFormField(
    initialValue: _title,
    decoration: InputDecoration(
    labelText: 'Title',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a title';
    }
    return null;
    },
    onSaved: (value) {
    _title = value!;
    },
    ),
    TextFormField(
    initialValue: _description,
    decoration: InputDecoration(
    labelText: 'Description',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a description';
    }
    return null;
    },
    onSaved: (value) {
    _description = value!;
    },
    ),
    TextFormField(
    initialValue: _url,
    decoration: InputDecoration(
    labelText: 'URL',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) { return 'Please enter a URL';
    }
    return null;
    },
      onSaved: (value) {
        _url = value!;
      },
    ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: _saveResource,
        child: Text('Save'),
      ),
    ],
    ),
    ),
    );
  }

  void _saveResource() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final resource = Resource(
        id: widget.resource.id,
        title: _title,
        description: _description,
        url: _url,
      );

      await FirebaseFirestore.instance
          .collection('resources')
          .doc(widget.resource.id)
          .update(resource.toMap());

      Navigator.pop(context);
    }
  }}

