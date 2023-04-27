import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/resourcemodel.dart';

abstract class ResourceEvent {}

class LoadResources extends ResourceEvent {

}

class AddResource extends ResourceEvent {
  final Resource resource;

  AddResource(this.resource);
}

class UpdateResource extends ResourceEvent {
  final Resource resource;

  UpdateResource(this.resource);
}

class DeleteResource extends ResourceEvent {
  final String id;

  DeleteResource(this.id);
}

abstract class ResourceState {}

class ResourceLoading extends ResourceState {}

class ResourceLoaded extends ResourceState {
  final List<Resource> resources;

  ResourceLoaded({required this.resources});
}

class ResourceError extends ResourceState {}

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ResourceBloc() : super(ResourceLoading()) {
    on<LoadResources>((event, emit) async* {
      yield* _mapLoadResourcesToState();
    });
    on<AddResource>((event, emit) async* {
      yield* _mapAddResourceToState(event.resource);
    });
  }

  @override
  Stream<ResourceState> mapEventToState(ResourceEvent event) async* {
    if (event is LoadResources) {
      yield* _mapLoadResourcesToState();
    } else if (event is AddResource) {
      yield* _mapAddResourceToState(event.resource);
    } else if (event is UpdateResource) {
      yield* _mapUpdateResourceToState(event.resource);
    } else if (event is DeleteResource) {
      yield* _mapDeleteResourceToState(event.id);
    }
  }

  Stream<ResourceState> _mapLoadResourcesToState() async* {
    yield ResourceLoading();
    try {
      final querySnapshot = await _firebaseFirestore.collection('resources').get();
      final List<Resource> resources =
      querySnapshot.docs.map((doc) => Resource.fromFirestore(doc)).toList();
      yield ResourceLoaded(resources: resources);
    } catch (e) {print(e);
      yield ResourceError();
    }
  }

  Stream<ResourceState> _mapAddResourceToState(Resource resource) async* {
    try {
      final documentReference =
      await _firebaseFirestore.collection('resources').add(resource.toFirestore());
      final addedResource = Resource(
        id: documentReference.id,
        title: resource.title,
        description: resource.description,
        url: resource.url,
      );
      final List<Resource> updatedResources = [...(state as ResourceLoaded).resources, addedResource];
      yield ResourceLoaded(resources: updatedResources);
    } catch (e) {
      print(e);
      yield ResourceError();
    }
  }

  Stream<ResourceState> _mapUpdateResourceToState(Resource resource) async* {
    try {
      await _firebaseFirestore
          .collection('resources')
          .doc(resource.id)
          .update(resource.toFirestore());
      final List<Resource> updatedResources = (state as ResourceLoaded).resources.map((r) {
        if (r.id == resource.id) {
          return resource;
        } else {
          return r;
        }
      }).toList();
      yield ResourceLoaded(resources: updatedResources);
    } catch (e) {
      yield ResourceError();
    }
  }

  Stream<ResourceState> _mapDeleteResourceToState(String id) async* {
    try {
      await _firebaseFirestore.collection('resources').doc(id).delete();
      final List<Resource> updatedResources =
      (state as ResourceLoaded).resources.where((r) => r.id != id).toList();
      yield ResourceLoaded(resources: updatedResources);
    } catch (e) {
      yield ResourceError();
    }
  }
}
