import 'package:firebase_database/firebase_database.dart';

class payments {
  String? clientname;
  String? phoneNumber;
  String? Mpesacode;
  String? paymentDate;
  double? amount;
  String? transactionstatus;
  String? clientmail;
  String? bookId;


  payments(
      {this.clientname,this.clientmail, this.phoneNumber, this.Mpesacode, this.paymentDate, this.amount,
        this.transactionstatus,this.bookId});


  payments.fromSnapshot(DataSnapshot dataSnapshot) {
    clientname = (dataSnapshot.child("cname").value.toString());
    clientmail = (dataSnapshot.child("email").value.toString());
    phoneNumber =  (dataSnapshot.child("phone").value.toString());
    Mpesacode =  (dataSnapshot.child("mpesacode").value.toString());
    paymentDate =  (dataSnapshot.child("paymentDate").value.toString());
    amount =  (dataSnapshot.child("amount").value.toString()) as double;
    bookId= (dataSnapshot.child("bookId").value.toString());
    transactionstatus =  (dataSnapshot.child("transactionStatus").value.toString());
  }

  //Receiving data from server
  factory payments.fromMap(map){
    return payments(
      clientmail: map['email'],
      transactionstatus: map['transactionStatus'],
      amount: map['amount'],
      paymentDate: map['paymentDate'],
      Mpesacode: map['mpesacode'],
      phoneNumber: map['phone'],
      clientname: map['cname'],
      bookId: map['bookId'],
    );
  }

//sending data to server
 Map<String, dynamic> toMap() {
    return {
      "email" : clientmail,
      "cname": clientname,
      "phone" : phoneNumber,
      "mpesacode" : Mpesacode,
      "amount": amount,
      'transactionStatus': transactionstatus,
      "paymentDate" : paymentDate,
      "bookId" : bookId,

    };
  }

  Map<String, dynamic> toJson() {
    return {
      "email" : clientmail,
      "cname": clientname,
      "phone" : phoneNumber,
      "mpesacode": Mpesacode,
      "amount": amount,
      'transactionStatus': transactionstatus,
      "paymentDate" :paymentDate,
      "bookId" :bookId,
    };
  }
}