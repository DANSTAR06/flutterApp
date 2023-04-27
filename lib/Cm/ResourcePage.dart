import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ultimate_excellence_limited/Cm/resource_bloc.dart';
import '../model/resourcemodel.dart';
import 'package:provider/provider.dart';



class Resourcepage extends StatefulWidget {
  @override
  _ResourcepageState createState() => _ResourcepageState();
}

class _ResourcepageState extends State<Resourcepage> {
  late final ResourceBloc _resourceBloc;


  @override
  void initState() {
    super.initState();
    _resourceBloc = ResourceBloc();
    _resourceBloc.add(LoadResources());
  }

  @override
  void dispose() {
    _resourceBloc.close();
    super.dispose();
  }

  void _showAddResourceDialog() {
    final _formKey = GlobalKey<FormState>();
    String title = '';
    String subtitle = '';
    String url = '';

    showDialog(
        context: context,
        builder: (_) {
      return AlertDialog(
          title: Text('Add Resource'),
          content: Form(
            key: _formKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
            TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onSaved: (value) => title = value!,
          ),
          TextFormField(
          decoration: InputDecoration(labelText: 'Subtitle'),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a subtitle';
    }
    return null;
    },
    onSaved : (value) => subtitle = value!,
          ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'URL'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }
                      return null;
                    },
                    onSaved: (value) => url = value!,
                  ),
                ],
            ),
          ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final resource = Resource(title: title, description: subtitle, url: url, id: '');
                _resourceBloc.add(AddResource(resource));
                context.read<ResourceBloc>().add(AddResource(resource));

                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      );
        },
    );
  }

  void _showUpdateResourceDialog(Resource resource) {
    final _formKey = GlobalKey<FormState>();
    String title = resource.title;
    String subtitle = resource.description;
    String url = resource.url;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Update Resource'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: resource.title,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) => title = value!,
                ),
                TextFormField(
                  initialValue: resource.description,
                  decoration: InputDecoration(labelText: 'Subtitle'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subtitle';
                    }
                    return null;
                  },
                  onSaved: (value) => subtitle = value!,
                ),
                TextFormField(
                  initialValue: resource.url,
                  decoration: InputDecoration(labelText: 'URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a URL';
                    }
                    return null;
                  },
                  onSaved: (value) => url = value!,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedResource = Resource(
                    id: resource.id,
                    title: title,
                    description: subtitle,
                    url: url,
                  );
                  _resourceBloc.add(UpdateResource(updatedResource));
                  Navigator.pop(context);
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteResourceDialog(String id) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Delete Resource'),
          content: Text('Are you sure you want to delete this resource?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _resourceBloc.add(DeleteResource(id));
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Resources'),
        ),
      body: BlocBuilder<ResourceBloc, ResourceState>(
        builder: (context, state) {
          if (state is ResourceLoading) {
            return Center(
              child: SpinKitChasingDots(size: 80,color: Colors.orange,),
            );
          } else if (state is ResourceLoaded) {
            final resources = state.resources;
            return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                return ListTile(
                  title: Text(resource.title),
                  subtitle: Text(resource.description),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showUpdateResourceDialog(resource);
                    },
                  ),
                  onLongPress: () {
                    showDeleteResourceDialog(resource.id);
                  },
                );
              },
            );
          } else if (state is ResourceError) {
            final error = ResourceError();
            return Center(
              child: Text(error.toString()),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddResourceDialog();
        },
      ),
    );
  }
}