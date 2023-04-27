import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/model/booksmodel.dart';
import 'package:ultimate_excellence_limited/ourBooks/bookReading.dart';

import '../pages/login.dart';
class BookPreviewPage extends StatelessWidget {
  const BookPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)?.settings.arguments as booksmodel;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              book.imageUrl,
              height: 200,

            ),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
                } else {
                  final hasPurchased = await hasUserPurchasedBook(user.email!, book.fullContentUrl);
                  if (hasPurchased) {
                    Navigator.pushNamed(
                      context,
                      '/book_reading',
                      arguments: book,
                    );

                  } else {
                    Navigator.pushNamed(
                      context,
                      '/book_purchase',
                      arguments: book,
                    );
                  }
                }
              },
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> hasUserPurchasedBook(String bookId, String fullContentUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    DataSnapshot snapshot = (await dbRef.child('userBooks').child(user.email!).child(bookId).once()) as DataSnapshot;
    return snapshot.value != null;
  }

}
