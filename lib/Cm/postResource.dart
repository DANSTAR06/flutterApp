import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickalert/quickalert.dart';

import '../model/resourcemodel.dart';
import 'editresources.dart';

class ResourceTable extends StatelessWidget {
  const ResourceTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Table'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('resources').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const  Text('Error');

          }
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: SpinKitChasingDots(size:80,color: Colors.orange,),
    );}

          if (!snapshot.hasData) {
            return const Center(child: SpinKitChasingDots(size: 80,color: Colors.pinkAccent,));
          }

          final resources = snapshot.data!.docs;

          return DataTable(
            columns: const [
              DataColumn(label: Text('Title')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('URL')),
              DataColumn(label: Text('')),
              //DataColumn(label: Text('')),
            ],
            rows: resources.map((resource) {
              final data = resource?.data() as Map<String, dynamic>?;
              // add the cast here

              if (data == null) {
                return DataRow(cells: [
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ]);
              }
              return DataRow(cells: [
                DataCell(Text(data['title'] ?? '')),
                DataCell(Text(data['description'] ?? '')),
                DataCell(Text(data['url'] ?? '')),
                DataCell(ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => EditResourcePage( resource: Resource.fromMap(data),)));
                      // add navigation code her
                  },
                  child: Text('Edit'),
                )),
              ]);
            }).toList(),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ResourceForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteResource(BuildContext context, String resourceId) async {
    try {
      await FirebaseFirestore.instance.collection('resources').doc(resourceId).delete();
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Failed to delete resource',
      );
    }
  }
}

class ResourceForm extends StatefulWidget {
  final String? resourceId;

  const ResourceForm({Key? key, this.resourceId}) : super(key: key);

  @override
  _ResourceFormState createState() => _ResourceFormState();
}

class _ResourceFormState extends State<ResourceForm> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late String _url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Post Resource'),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    TextFormField(
    decoration: const InputDecoration(
    labelText: 'Title',
    ),
    initialValue: _title,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a title';
    }
    return null;
    },
    onChanged: (value) {
    _title = value;
    },
    ),
    TextFormField(
    decoration: const InputDecoration(
    labelText: 'Description',
    ),
    initialValue: _description,
    validator:                 (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a description';
      }
      return null;
    },
      onChanged: (value) {
        _description = value;
      },
    ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'URL',
        ),
        initialValue: _url,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a URL';
          }
          return null;
        },
        onChanged: (value) {
          _url = value;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {

            // Save the resource to the database
            _saveResource();

            // Return to the previous screen
            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
      if (widget.resourceId != null)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  _deleteResource();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _updateResource();
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
    ],
    ),
    ),
    ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.resourceId != null) {
      _getResource();
    } else {
      _title = '';
      _description = '';
      _url = '';
    }
  }

  void _getResource() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('resources')
        .doc(widget.resourceId)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      _title = data['title'];
      _description = data['description'];
      _url = data['url'];
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Resource not found',
        text: 'The requested resource could not be found',
      );
    }
  }

  void _saveResource() async {
    final data = {
      'title': _title,
      'description': _description,
      'url': _url,
    };
    await FirebaseFirestore.instance.collection('resources').add(data);
  }

  void _updateResource() async {
    final data = {
      'title': _title,
      'description': _description,
      'url': _url,
    };

    await FirebaseFirestore.instance
        .collection('resources')
        .doc(widget.resourceId)
        .update(data);
  }

  void _deleteResource() async {
    await FirebaseFirestore.instance
        .collection('resources')
        .doc(widget.resourceId)
        .delete();
  }
}
