import 'dart:convert' show Encoding, base64, base64Encode;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

String pdfAssetPath = 'assets/dmwdocfull.pdf';
ByteData data =  rootBundle.load(pdfAssetPath) as ByteData;
List<int> bytes = data.buffer.asUint8List();
String base64Data = base64Encode(bytes);
Uri pdfUri = Uri.dataFromBytes(bytes, mimeType: 'application/pdf');
class booksmodel {
  late final String title;
  late final String author;
   late final String imageUrl;
  late final String previewUrl;
  late final String fullContentUrl;
  late final  double price;


  booksmodel({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.previewUrl,
    required this.fullContentUrl,
    required this.price,

  });
factory booksmodel.fromMap(map){
    return booksmodel(
        title: map['Title'],
        author: map['Author'],
        imageUrl: map['Imagepreview'],
        previewUrl: map['Bookpreview'],
        fullContentUrl: map['Fullbook'],
        price: map['bookcost'],
    );}

  Map<String, dynamic> toJson(){
    return{
      "Title" : title,
      'Author' : author,
      "Imagepreview": imageUrl,
      "Bookpreview": previewUrl,
      'Fullbook': fullContentUrl,
      'bookcost': price,

    };
  }

booksmodel.fromSnapshot(DataSnapshot dataSnapshot, this.title, this.author, this.imageUrl, this.previewUrl, this.fullContentUrl, this.price) {
    title = (dataSnapshot.child("Title").value.toString());
    author =  (dataSnapshot.child("Author").value.toString());
    imageUrl =  (dataSnapshot.child("Imagepreview").value.toString());
    previewUrl =  (dataSnapshot.child("Bookpreview").value.toString());
    fullContentUrl =  (dataSnapshot.child("Fullbook").value.toString());
    price =  (dataSnapshot.child("bookcost")) as double;
  }
}