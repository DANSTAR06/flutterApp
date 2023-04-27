import'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ultimate_excellence_limited/model/booksmodel.dart';
import 'package:ultimate_excellence_limited/ourBooks/bookReading.dart';
import 'package:ultimate_excellence_limited/pages/aboutUs.dart';
import 'package:ultimate_excellence_limited/pages/settings.dart';
import 'package:ultimate_excellence_limited/pages/sidebar.dart';
import 'package:ultimate_excellence_limited/pages/signup.dart';
import 'package:ultimate_excellence_limited/pages/userprofile.dart';
// import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
import 'package:ultimate_excellence_limited/splashscreen.dart';

import 'books/bookPreview.dart';
import 'books/bookPurchase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          '/book_preview': (context) => BookPreviewPage(),
          '/book_purchase': (context) => BookPurchasePage(),
         // '/book_reading': (context) => bookReading(book: booksmodel.fromMap(booksmodel)),
        },
        home: splashscreen());
  }
}



