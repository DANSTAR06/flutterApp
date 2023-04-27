import 'package:firebase_database/firebase_database.dart';

class userbook{
  String? useremail;
  String? bookId;

  userbook({required this.bookId, required this.useremail});

  userbook.fromSnapshot(DataSnapshot dataSnapshot) {
    useremail = (dataSnapshot.child("clientId").value.toString());
    bookId =  (dataSnapshot.child("bookId").value.toString());

  }

  //Receiving data from server
  factory userbook.fromMap(map){
    return userbook(
      useremail: map['clientId'],
      bookId: map['bookId'],

    );
  }

//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'clientId' : useremail,
      'bookId': bookId,


    };
  }

  Map<String, dynamic> toJson() {
    return {
      "clientId": useremail,
      'bookId' : bookId,
    };
  }

}