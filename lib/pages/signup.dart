import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ultimate_excellence_limited/model/usermodel.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
import 'package:quickalert/quickalert.dart';
import 'package:image_picker/image_picker.dart';
class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);



  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {

  final auth = FirebaseAuth.instance;


  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isLoading=false;
 File? _selectedImage;



  final formkey = GlobalKey<FormState>();
  final locationformkey = GlobalKey<FormState>();
  final usertypeformkey = GlobalKey<FormState>();
  final maritalformkey = GlobalKey<FormState>();
  final genderkey = GlobalKey<FormState>();
  final mformkey = GlobalKey<FormState>();
  final nformkey = GlobalKey<FormState>();
  final oformkey = GlobalKey<FormState>();
  final phoneformkey = GlobalKey<FormState>();

  String _userType="Select Type of User";
  String _selectedGender="Select gender";
  String _selectedstatus = "Select Marriage Status";
  final PhoneNumbercontroller = new TextEditingController();
  final usernamecontroller = new TextEditingController();
  final emailcontroller = new TextEditingController();
  final passwordcontroller = new TextEditingController();
  final confirmpasswordcontroller = new TextEditingController();
  final locationcontroller = new TextEditingController();

  String? url;
  DatabaseReference _userRef=FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    _userRef = FirebaseDatabase.instance.reference().child('clientData');
  }



  void pickimagegallery()async {
    final picker = ImagePicker();

    final selectedImage = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 100);
    final pickedimagefile = File(selectedImage!.path);
    setState(() {
      _selectedImage = pickedimagefile;
    });
    Navigator.pop(context);
  }
    void imagecamera() async{
      final picker=ImagePicker();
      final selectedImage=await picker.getImage(source: ImageSource.camera);
      final pickedimagefile=File(selectedImage!.path);setState(() {
        _selectedImage= pickedimagefile;
      });

    }
  void removeimage(){
    setState(() {
      _selectedImage=null ;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      // appBar: AppBar(title:Text("UEMA",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24.0,fontFamily:
      //     "NotoSansMono",
      // letterSpacing: 1.5),),
      //   centerTitle: true,backgroundColor: Colors.deepOrangeAccent,
      //   elevation:0.0,
      // ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                width: w,
                height: h * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/ultimate.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Container(
                width: w,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: [
                        Icon(Icons.handshake, color: Colors.white70),
                        SizedBox(width: 10.0,),
                        Text("HELLO!!",
                          style: TextStyle(fontFamily: "NotoSansMono",
                              fontWeight: FontWeight.w700, fontSize: 24.0),),
                      ]),
                      Text("Sign up for Your Mental Health Account",
                          style: TextStyle(fontSize: 14.0, fontWeight:
                          FontWeight.w400, fontFamily: "NotoSansMono")),

                      SizedBox(height: 10.0),

                      Form(
                        key: usertypeformkey,
                        child: DropdownButtonFormField(

                          decoration: InputDecoration(
                            focusColor: Colors.brown,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.account_box,color: Colors.cyanAccent,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                            labelStyle: TextStyle(fontSize: 20.0, fontWeight:
                            FontWeight.w900, fontFamily: "NotoSansMono",color: Colors.lightGreenAccent),



                            labelText: "User Type",
                          ),
                          value: _userType,
                          items: <String>['Select Type of User', 'Client', 'Counselor', 'Mentor', 'Service Manager', 'Content Manager']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: TextStyle(fontSize: 14.0, fontWeight:
                              FontWeight.w800, fontFamily: "NotoSansMono"),),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {

                                    _userType = value!;
                                   switch (_userType)
                                   {
                                       case 'Client':
                                          _userRef= FirebaseDatabase.instance.reference().child('clientData');
                                      break;
                                            case 'Counselor':
                                             _userRef = FirebaseDatabase.instance.reference().child('counselorData');
                                      break;
                                               case 'Mentor':
                                                 _userRef = FirebaseDatabase.instance.reference().child('mentorData');
                                      break;
                                                case 'Service Manager':
                                           _userRef = FirebaseDatabase.instance.reference().child('smData');
                                      break;
                                     case 'Content Manager':
                                       _userRef = FirebaseDatabase.instance.reference().child('cmData');
                                       break;
                                     default:
                                         _userRef = FirebaseDatabase.instance.reference().child('clientData');
                                   break;
                           }
                            });
                          },
                          validator: (value) {
                            if(value! == 'Select Type of User')
                              {
                                return "Alert! UserType Is required, Select";
                              }
                            return null;
                          },
                          icon: const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.greenAccent,),
                          dropdownColor: Colors.cyan.shade300,

                        ),
                      ),
                      SizedBox(height: 10),

                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              child: CircleAvatar(
                                radius: 81,
                                backgroundColor: Colors.black45,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: _selectedImage ==null ?null :
                                  FileImage(_selectedImage!),
                                ),
                              ),

                            ),
                            Positioned(
                              bottom: 0,right: 20,
                              child: RawMaterialButton(
                                elevation: 10,
                                    fillColor: Colors.green,
                                    shape: CircleBorder(),
                               child: Icon(
                                  Icons.add_a_photo_outlined, color: Colors.black,),
                                onPressed: ()
                                async {
                                  showDialog(context: context, builder: (BuildContext context){
                                    return AlertDialog(title: Text("Choose image From",
                                      style: TextStyle(fontSize: 14.0, fontWeight:
                                      FontWeight.w400, fontFamily: "NotoSansMono",color:
                                      Colors.cyanAccent),),
                                      content: SingleChildScrollView(
                                        child: ListBody(children: [
                                          InkWell(
                                            onTap:(){imagecamera();},
                                            splashColor: Colors.cyanAccent,child: Row(
                                            children: [Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Icon(Icons.camera_alt_outlined,color: Colors.brown),
                                            ),Text("Camera",style: TextStyle(fontSize: 14.0,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontFamily: "NotoSansMono",color:Colors.brown),
                                            )],
                                          ),



                                          ),
                                          InkWell(
                                            onTap:(){pickimagegallery();},
                                            splashColor: Colors.cyanAccent,child: Row(
                                            children: [Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Icon(Icons.image,color: Colors.brown),
                                            ),Text("Gallery",style: TextStyle(fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "NotoSansMono",color:Colors.brown),
                                            )],
                                          ),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              removeimage();
                                            },
                                            splashColor: Colors.cyanAccent,child: Row(
                                            children: [Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Icon(Icons.delete_forever,color: Colors.brown),
                                            ),Text("Remove Image",style: TextStyle(fontSize: 14.0,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontFamily: "NotoSansMono",color:Colors.brown),
                                            )],
                                          ),



                                          ),
                                        ],),
                                      ),);
                                  }
                                  );
                                },
                                ),
                              )],
                            )
                      )
                         ] 
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,5,20,0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white70,
                              boxShadow: [BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                  spreadRadius: 10.0,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )
                              ]
                          ),
                          child: Form(
                            key: formkey,
                            child: TextFormField(

                              style: TextStyle(fontSize: 14,
                                  fontFamily: 'NotoSansMono',
                                  fontWeight: FontWeight.w400),
                              controller: usernamecontroller,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                usernamecontroller.text = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Kindly Your Full name is Required";
                                }
                                if(value.length < 5)
                                  {
                                    return "Full Name too Short";
                                  }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                      Icons.person, color: Colors.deepOrange),
                                  labelText: "Full Name",
                                  hintText: "Full Name",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,5,20,0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                      boxShadow: [BoxShadow(
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          spreadRadius: 10.0,
                          color: Colors.deepOrange.withOpacity(0.2)
                      )
                      ]
                  ),
                  child: Form(
                    key: locationformkey,
                    child: TextFormField(

                      style: TextStyle(fontSize: 14,
                          fontFamily: 'NotoSansMono',
                          fontWeight: FontWeight.w400),
                      controller: locationcontroller,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        locationcontroller.text = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Your Location is Required";
                        }
                        if(value.length < 7)
                        {
                          return "Location detail too Short";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                              CupertinoIcons.location_solid, color: Colors.deepOrange),
                          labelText: "Location",
                          hintText: "Location Address",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.5,
                              )

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.5,
                              )

                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ),
                      SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,5,20,0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                      boxShadow: [BoxShadow(
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          spreadRadius: 10.0,
                          color: Colors.deepOrange.withOpacity(0.2)
                      )
                      ]
                  ),
                  child: Form(
                    key: genderkey,
                    child: DropdownButtonFormField<String>(

                      value: _selectedGender,
                      items: <String>['Select gender','Male', 'Female', 'Rather Not Say']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontSize: 14.0,
                            fontWeight:
                            FontWeight.w400,
                            fontFamily: "NotoSansMono",color:Colors.brown,),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                      validator: (value) {
                        if (value! == 'Select gender') {
                          return 'Please select your gender';
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person_crop_circle,
                              color: Colors.green),
                          labelText: "Select Gender",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.5,
                              )

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.lightGreen,
                                width: 1.5,
                              )

                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),dropdownColor: Colors.cyanAccent,
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.redAccent,),
                    ),
                  ),
                ),
              ),
                      SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,5,20,0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                      boxShadow: [BoxShadow(
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          spreadRadius: 10.0,
                          color: Colors.deepOrange.withOpacity(0.2)
                      )
                      ]
                  ),
                  child: Form(
                    key: maritalformkey,
                    child: DropdownButtonFormField<String>(

                      value: _selectedstatus,
                      items: <String>['Single', 'Divorced', 'Engaged','Widowed','Select Marriage Status']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(

                          value: value,
                          child: Text(value,style: TextStyle(fontSize: 14.0,
                              fontWeight:
                              FontWeight.w400,
                              fontFamily: "NotoSansMono",color:Colors.brown),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedstatus = value!;
                        });
                      },
                      validator: (value) {
                        if (value! == 'Select Marriage Status') {
                          return 'Please select your Marital Status';
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person_crop_rectangle_fill,
                              color: Colors.pink),
                          labelText: "Marriage Status",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              )

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 1.5,
                              )

                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),dropdownColor: Colors.cyan.shade300,
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.red,),
                    ),
                  ),
                ),
              ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,5,20,0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white70,
                              boxShadow: [BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                  spreadRadius: 10.0,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )
                              ]
                          ),
                          child: Form(
                            key: mformkey,
                            child: TextFormField(

                              style: TextStyle(fontSize: 14,
                                  fontFamily: 'NotoSansMono',
                                  fontWeight: FontWeight.w400),
                              autofocus: false,
                              controller: emailcontroller,
                              onSaved: (value) {
                                emailcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Alert!, Email is Required");
                                }
                                //email format validation
                                if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("INVALID Email!!, check your typing");
                                }
                                return null;
                              },

                              decoration: InputDecoration(
                                labelText: "Email",
                                  prefixIcon: Icon(Icons.email_outlined,
                                      color: Colors.deepOrange),
                                  hintText: "Email",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,5,20,0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                      boxShadow: [BoxShadow(
                          blurRadius: 7,
                          offset: Offset(1, 1),
                          spreadRadius: 7.0,
                          color: Colors.deepOrange.withOpacity(0.2)
                      )
                      ]
                  ),
                  child: Form(
                    key: phoneformkey,
                    child: TextFormField(

                      validator: (value) {

                        RegExp regexp = new RegExp('^254+[0-9]');
                        if (value!.isEmpty) {
                          return "Kindly type in Your Phone Number";
                        }

                        if(value.length < 10 || value.length >12)
                        {
                          return "Provide a Valid Phone Number";
                        }

                        if (!regexp.hasMatch(value)) {
                          return "Phone Number  format should be +254 then 9digits number";
                        }
                      },
                      controller: PhoneNumbercontroller,
                      autofocus: false,
                      onSaved: (value) {
                        PhoneNumbercontroller.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 14,
                          fontFamily: 'NotoSansMono',
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone_android_outlined,
                            color: Colors.deepOrange,),
                          hintText: "Phone Number",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.5,
                              )

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 1.5,
                              )

                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),

                       keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,5,20,0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white70,
                              boxShadow: [BoxShadow(
                                  blurRadius: 7,
                                  offset: Offset(1, 1),
                                  spreadRadius: 7.0,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )
                              ]
                          ),
                          child: Form(
                            key: nformkey,
                            child: TextFormField(

                              validator: (value) {
                                RegExp regexp = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Kindly type in Your Password";
                                }
                                if (!regexp.hasMatch(value)) {
                                  return "Password must not be less than 6 characters!";
                                }
                              },
                              controller: passwordcontroller,
                              autofocus: false,
                              onSaved: (value) {
                                passwordcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              style: TextStyle(fontSize: 14,
                                  fontFamily: 'NotoSansMono',
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.password_outlined,
                                    color: Colors.deepOrange,),
                                  hintText: "Password",
                                  labelText: 'Password',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              obscureText: true,
                              // keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,5,20,0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white70,
                              boxShadow: [BoxShadow(
                                  blurRadius: 7,
                                  offset: Offset(1, 1),
                                  spreadRadius: 7.0,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )
                              ]
                          ),
                          child: Form(
                            key: oformkey,
                            child: TextFormField(

                              style: TextStyle(fontSize: 14,
                                  fontFamily: 'NotoSansMono',
                                  fontWeight: FontWeight.w400),
                              autofocus: false,
                              controller: confirmpasswordcontroller,
                              onSaved: (value) {
                                confirmpasswordcontroller.text = value!;
                              },
                              validator: (value) {
                                if (confirmpasswordcontroller.text != passwordcontroller.text)
                                {
                                  return "Password Entries did not match!!";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_open, color: Colors.deepOrange,),
                                  hintText: "Confirm Password",
                                  labelText: "Confirm Password",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white70,
                                        width: 1.5,
                                      )

                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        ),
                      ),
              
              SizedBox(height: 10.0,),
          isLoading ? SpinKitWave(size: 90,color: Colors.deepPurple,):
              Center(
                child: Container(
                    width: w * 0.95,
                    height: h * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.white,
                    ),

                    child: TextButton.icon(onPressed: () {
                      signup(emailcontroller.text.trim(), passwordcontroller.text.toString());

                    },
                      icon: Icon(Icons.upload, color: Colors.deepOrange),
                      label: Text
                        ("SIGNUP", style: TextStyle(fontFamily: "NotoSansMono",
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Colors.deepOrange),)
                      ,
                    )),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: Text(
                        "Already Having an Account?", style: TextStyle(
                          fontFamily: "NotoSansMono",
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0
                      ),),),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => loginscreen()));
                      }, child: Text(
                        "Login Here >", style: TextStyle(
                          fontFamily: 'NotoSansMono',
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                          color:
                          Colors.deepPurple),
                      )),
                    ]
                ),
              )
            ]
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    if (usertypeformkey.currentState!.validate() && formkey.currentState!.validate() && genderkey.currentState!.validate() &&
        mformkey.currentState!.validate() && maritalformkey.currentState!.validate() && phoneformkey.currentState!.validate()
        && nformkey.currentState!.validate() && oformkey.currentState!.validate() && locationformkey.currentState!.validate()
    )
    {

      setState(() {
        isLoading = true;
      });


      if (_selectedImage == null) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text("NOTE you have note selected profile Image"),
              actions: [TextButton(onPressed: () async {
                setState(() {
                  isLoading=false;
                });
                Navigator.pop(context);
              }, child: Text("OKAY"))
              ]);
        });

      } else {
        final ref = FirebaseStorage.instance.ref().child('ImagePath');
        await ref.putFile(_selectedImage!);
        url = await ref.getDownloadURL();
      }        await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
      {
        postDetailsToFirestore()
      }).catchError((e) {
        print(e);
        showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text(e.message.toString(),),
              actions: [TextButton(onPressed: () async {
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);
              }, child: Text("OKAY"))
              ]);
        });
      });
      setState(() {
        isLoading = true;
      });



    }

  }
  postDetailsToFirestore() async
  {
    Map<String, dynamic> userData = {
      'fname': usernamecontroller.text.toString().trim(),
      'gender': _selectedGender,
      'marital': _selectedstatus,
      'phone': PhoneNumbercontroller.text,
      'email': emailcontroller.text.toString().trim(),
      'pass': passwordcontroller.text,
      'location' : locationcontroller.text.toString(),
      'status': 'pending',
    };
    try {

      await _userRef.push().set(userData);
      Fluttertoast.showToast(
        msg: "Account Created Successfully...You can LOGIN NOW",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 30,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      QuickAlert.show(context: context, type: QuickAlertType.success,title: "Success",text: "Registration Was SUCCESSFULLY",textColor: Colors.cyan,titleColor: Colors.redAccent,
          borderRadius: 20,autoCloseDuration: Duration(seconds: 5));
      Navigator.pushAndRemoveUntil(
          (context), MaterialPageRoute(builder: (context) => loginscreen()),
              (route) => false);
    }catch (e) {
      setState(() {
        isLoading = false;
      });
// Handle errors
      QuickAlert.show(context: context, type: QuickAlertType.error,title: "FAILED",cancelBtnText:
      "OKAY",text: "Your Registration was not Successfull :$e",textColor: Colors.cyan,titleColor: Colors.red,
          backgroundColor: Colors.deepPurple,cancelBtnTextStyle: TextStyle(fontFamily: "NotoSansMono",
            fontWeight: FontWeight.w800,
            fontSize: 20.0,),borderRadius: 25);


      /*showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text('Error registering user: $e'),
            actions: [TextButton(onPressed: () async {

              Navigator.pop(context);
            }, child: Text("OKAY"))
            ]);
      });*/
    }


    //calling firestore
    //call umodel
    // sending values

    /*User? user = auth.currentUser;
    usermodel UserModel = usermodel();

    //writing values
    UserModel.email = user!.email;
    UserModel.imagepath = url;
    UserModel.password = passwordcontroller.text;
    UserModel.username = usernamecontroller.text;
    UserModel.marital=_selectedstatus;
    UserModel.sex = _selectedGender;
    UserModel.mobile = PhoneNumbercontroller.text;
    UserModel.Location = locationcontroller.text;
    UserModel.userType=_userType;*/



    //await _userRef.push().set(UserModel.toMap());



  }


}
