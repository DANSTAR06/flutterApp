import 'package:cloud_firestore/cloud_firestore.dart';

class Resource {
  final String id;
  final String title;
  final String description;
  final String url;

  Resource({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
  });

  factory Resource.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Resource(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      url: data['url'] ?? '',
    );
  }
  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
    };
  }

  Map<String, dynamic> fromMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'url': url,
    };
  }
}
