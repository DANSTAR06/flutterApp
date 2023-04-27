import 'package:firebase_database/firebase_database.dart';

class usermodel {
  String? username;
  String? password;
  String? imagepath;
  String? email;
  String? marital;
  String? sex;
  String? userType;
  String? mobile;
  String? status;
  String? Location;




  usermodel(
      {this.Location, this.status, this.username, this.email, this.password, this.imagepath, this.userType, this.marital,this.sex,this.mobile});


  usermodel.fromSnapshot(DataSnapshot dataSnapshot) {
    email = (dataSnapshot.child("email").value.toString());
    username =  (dataSnapshot.child("fname").value.toString());
    password =  (dataSnapshot.child("pass").value.toString());
    mobile =  (dataSnapshot.child("phone").value.toString());
    status =  (dataSnapshot.child("status").value.toString());
    Location =  (dataSnapshot.child("phone").value.toString());
    marital =  (dataSnapshot.child("Marital").value.toString());
    sex =  (dataSnapshot.child("gender").value.toString());
  }



  //Receiving data from server
  factory usermodel.fromMap(map){
      return usermodel(
        status: map['pending'],
        password: map['password'],
        imagepath: map['ImagePath'],
        username: map['UserName'],
        email: map['Email'],
        marital: map['Marital'],
        sex: map['gender'],
        mobile: map['phone'],
        Location: map['location'],


    );
  }

//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'pending' : status,
      'UserName': username,
      'Email': email,
      'ImagePath': imagepath,
      'password': password,
      'Marital': marital,
      'gender': sex,
      'location' : Location,
      'phone': mobile,

    };
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      'pending' : status,
      "password": password,
      "userType": userType,
      'gender': sex,
      'Marital': marital,
      'phone': mobile,
      'location' : Location,

    };
  }
}