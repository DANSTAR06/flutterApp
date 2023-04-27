import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class appointment{
late String serviceName;
late String clientName;
late DateTime dateTime;
late String bookingType;
late String email;
late String phone;
String? userId;

appointment({required this.dateTime,required this.clientName,required this.serviceName,required this.phone,
required this.email, required this.bookingType, required userId});

appointment.fromSnapshot(DataSnapshot dataSnapshot) {
  email = (dataSnapshot.child("clientEmail").value.toString());
  clientName =  (dataSnapshot.child("clientName").value.toString());
  serviceName =  (dataSnapshot.child("serviceName").value.toString());
  phone =  (dataSnapshot.child("clientPhone").value.toString());
  dateTime =  (dataSnapshot.child("bookingDate").value.toString()) as DateTime;
  bookingType =  (dataSnapshot.child("bookingType").value.toString());

}
Map<String, dynamic> toJson() {
  return {
    "clientEmail": email,
    "clientName": clientName,
    "bookingType": bookingType,
    'bookingDate': dateTime,
    'clientPhone': phone,
    'serviceName': serviceName,

  };
}
factory appointment.fromMap(map){
  return appointment(
    email: map['clientEmail'],
    clientName: map['clientName'],
    phone: map['clientPhone'],
    serviceName: map['serviceName'],
    dateTime: map['BookingDate'],
    bookingType: map['bookingType'],
    userId: map['UID'],);
}


}