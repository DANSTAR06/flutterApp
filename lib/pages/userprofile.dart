import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultimate_excellence_limited/pages/home.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
import 'package:ultimate_excellence_limited/pages/sidebar.dart';
import '../model/usermodel.dart';
class userprofile extends StatefulWidget {
  const userprofile({Key? key}) : super(key: key);

  @override
  State<userprofile> createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {

  final globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  DatabaseReference _userRef=FirebaseDatabase.instance.reference().root;

  User? user = FirebaseAuth.instance.currentUser;
  usermodel loggedinuser = usermodel();
  File? _selectedImage;
  String ? url;
  FirebaseAuth auth = FirebaseAuth.instance;
  final confirmpasswordcontroller = new TextEditingController();
  final usernameholder = new TextEditingController();
  final passwordholder = new TextEditingController();
  final emailholder = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userRef.get()
        .then((value) =>
        setState(() => this.loggedinuser = usermodel.fromMap(value)));
  }


  final _icon = CupertinoIcons.moon_stars;
  late final bool isDarkMode;

  bool showPassword = false;

  void pickimagegallery() async {
    final picker = ImagePicker();
    final selectedImage = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 100);
    final pickedimagefile = File(selectedImage!.path);
    setState(() {
      _selectedImage = pickedimagefile;
    });
    Navigator.pop(context);
  }

  void imagecamera() async {
    final picker = ImagePicker();
    final selectedImage = await picker.getImage(source: ImageSource.camera);
    final pickedimagefile = File(selectedImage!.path);
    setState(() {
      _selectedImage = pickedimagefile;
    });
  }

  void removeimage() {
    setState(() {
      loggedinuser.imagepath = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(leading: IconButton(onPressed: () {
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => home()));
        }
      },
        icon: Icon(Icons.arrow_back, color: Colors.white,),),
        elevation: 1,
        backgroundColor: Colors.black45, actions: [IconButton
          (onPressed: () {}, icon: IconButton(onPressed: () {
          isDarkMode = true;
        }, icon: Icon(_icon),))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(onTap: () {
            FocusScope.of(context).unfocus();
          },
            child: ListView(
                children: [
                  Text("MY Profile", style: TextStyle(
                      fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                      fontSize: 24.0, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Row(
                      children: [
                        InkWell(
                            child: Container(

                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(
                                    "${loggedinuser.imagepath}"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                border: Border.all(width: 2),
                                color: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                              ),

                            ), splashColor: Colors.cyanAccent,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            }

                        ),
                        // Positioned(
                        //   bottom: 0, right: 0,
                        //   child: Container(
                        //     height: 50,
                        //     width: 35,
                        //     decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color: Colors.lightGreen),
                        //     child: IconButton(
                        //         icon: Icon(
                        //           Icons.add_a_photo_outlined,
                        //           color: Colors.white60,),
                        //         onPressed: () {
                        //           showDialog(context: context,
                        //               builder: (BuildContext context) {
                        //                 return AlertDialog(
                        //                   title: Text("Choose image From",
                        //                     style: TextStyle(
                        //                         fontSize: 14.0,
                        //                         fontWeight:
                        //                         FontWeight.w400,
                        //                         fontFamily: "NotoSansMono",
                        //                         color:
                        //                         Colors.cyanAccent),),
                        //                   content: SingleChildScrollView(
                        //                     child: ListBody(children: [
                        //                       InkWell(
                        //                         onTap: () {setState(() {
                        //
                        //                         });
                        //                           imagecamera();
                        //                         },
                        //                         splashColor: Colors
                        //                             .cyanAccent, child: Row(
                        //                         children: [
                        //                           Padding(
                        //                             padding: const EdgeInsets
                        //                                 .all(18.0),
                        //                             child: Icon(Icons
                        //                                 .camera_alt_outlined,
                        //                                 color: Colors.brown),
                        //                           ),
                        //                           Text("Camera",
                        //                             style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontWeight:
                        //                                 FontWeight.w400,
                        //                                 fontFamily: "NotoSansMono",
                        //                                 color: Colors.brown),
                        //                           )
                        //                         ],
                        //                       ),
                        //
                        //
                        //                       ),
                        //                       InkWell(
                        //                         onTap: () {
                        //                           setState(() {
                        //
                        //                           });
                        //                           pickimagegallery();
                        //                         },
                        //                         splashColor: Colors
                        //                             .cyanAccent, child: Row(
                        //                         children: [
                        //                           Padding(
                        //                             padding: const EdgeInsets
                        //                                 .all(18.0),
                        //                             child: Icon(Icons.image,
                        //                                 color: Colors.brown),
                        //                           ),
                        //                           Text("Gallery",
                        //                             style: TextStyle(
                        //                                 fontSize: 14.0,
                        //                                 fontWeight: FontWeight
                        //                                     .w400,
                        //                                 fontFamily: "NotoSansMono",
                        //                                 color: Colors.brown),
                        //                           )
                        //                         ],
                        //                       ),
                        //                       ),
                        //                       // InkWell(
                        //                       //   onTap: () {
                        //                       //     removeimage();
                        //                       //   },
                        //                       //   splashColor: Colors
                        //                       //       .cyanAccent, child: Row(
                        //                       //   children: [
                        //                       //     Padding(
                        //                       //       padding: const EdgeInsets
                        //                       //           .all(18.0),
                        //                       //       child: Icon(
                        //                       //           Icons.delete_forever,
                        //                       //           color: Colors.brown),
                        //                       //     ),
                        //                       //     Text("Remove Image",
                        //                       //       style: TextStyle(
                        //                       //           fontSize: 14.0,
                        //                       //           fontWeight:
                        //                       //           FontWeight.w400,
                        //                       //           fontFamily: "NotoSansMono",
                        //                       //           color: Colors.brown),
                        //                       //     ),
                        //                       //   ],
                        //                       // ),
                        //                       // ),
                        //                     ],),
                        //                   ),);
                        //               }
                        //           );
                        //         }
                        //
                        //
                        //     ),
                        //   ),
                        // )
                        SizedBox(width: 8),
                        Text("Change image>>", style: TextStyle(
                            fontFamily: 'NotoSansMono',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            color: Colors.black),),
                        SizedBox(width: 10,),
                        SingleChildScrollView(
                          child: Stack(

                            children: [
                              Container(
                                height: 140,
                                width: 140,
                                child: CircleAvatar(
                                  radius: 81,
                                  backgroundColor: Colors.white70,
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: _selectedImage == null
                                        ? null
                                        :
                                    FileImage(_selectedImage!),
                                  ),
                                ),

                              ),
                              Positioned(
                                bottom: 0, right: 0,
                                child: RawMaterialButton(
                                  elevation: 5,
                                  fillColor: Colors.green,
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.black,),
                                  onPressed: () async {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Choose image From",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontFamily: "NotoSansMono",
                                                  color:
                                                  Colors.cyanAccent),),
                                            content: SingleChildScrollView(
                                              child: ListBody(children: [
                                                InkWell(
                                                  onTap: () {
                                                    imagecamera();
                                                  },
                                                  splashColor: Colors
                                                      .cyanAccent, child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(18.0),
                                                      child: Icon(Icons
                                                          .camera_alt_outlined,
                                                          color: Colors.brown),
                                                    ),
                                                    Text("Camera",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily: "NotoSansMono",
                                                          color: Colors.brown),
                                                    )
                                                  ],
                                                ),


                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    pickimagegallery();
                                                  },
                                                  splashColor: Colors
                                                      .cyanAccent, child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(18.0),
                                                      child: Icon(Icons.image,
                                                          color: Colors.brown),
                                                    ),
                                                    Text("Gallery",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontFamily: "NotoSansMono",
                                                          color: Colors.brown),
                                                    )
                                                  ],
                                                ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    removeimage();
                                                  },
                                                  splashColor: Colors
                                                      .cyanAccent, child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(18.0),
                                                      child: Icon(Icons
                                                          .delete_forever,
                                                          color: Colors.brown),
                                                    ),
                                                    Text("Remove Image",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily: "NotoSansMono",
                                                          color: Colors.brown),
                                                    )
                                                  ],
                                                ),


                                                ),
                                              ],),
                                            ),);
                                        }
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )


                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Form(key: globalKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(fontSize: 14,
                              fontFamily: 'NotoSansMono',
                              fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.text,
                          controller: usernameholder,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return value = loggedinuser.username;
                            }
                          },
                          onSaved: (value) {
                            usernameholder.text = value!;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                                Icons.person, color: Colors.cyanAccent),
                            hintText: "${loggedinuser.username}",

                          ),),
                        SizedBox(height: 10),
                        TextFormField(

                          style: TextStyle(fontSize: 14,
                              fontFamily: 'NotoSansMono',
                              fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailholder,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return value = loggedinuser.email;
                            }
                            if (!RegExp(
                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("INVALID Email!!, check your typing");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            loggedinuser.email = value!;
                          },
                          decoration: InputDecoration(

                            prefixIcon: Icon(
                                Icons.email_outlined, color: Colors.cyanAccent),
                            hintText: "${loggedinuser.email}",
                          ),),
                        SizedBox(height: 30),
                        Text("MY BIO", style: TextStyle(fontSize: 14,
                            fontFamily: 'NotoSansMono',
                            fontWeight: FontWeight.w400),),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: confirmpasswordcontroller,
                          style: TextStyle(fontSize: 14,
                              fontFamily: 'NotoSansMono',
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.account_box, color: Colors.cyanAccent),
                              hintText: "${loggedinuser.password}",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(70),
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                    width: 2,))
                          ),
                        )

                      ],),
                  ),


                  SizedBox(height: 50,),
                  FloatingActionButton.extended(onPressed: () async {
                    await updateUserdata
                      (usernameholder.text, confirmpasswordcontroller.text);
                  }

                    , icon: Icon(Icons.save_sharp, color:
                    Colors.deepOrangeAccent,),
                    backgroundColor: Colors.cyan,
                    label: Text("Save Profile", style: TextStyle(
                      fontFamily: 'NotoSansMono',
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,),),),

                  // Row(mainAxisAlignment: MainAxisAlignment.end,
                  //
                  //
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(splashColor: Colors.green,
                  //         child: FloatingActionButton.extended(onPressed: () {},
                  //           icon: Icon(Icons.delete_forever_sharp, color:
                  //           Colors.cyanAccent,),
                  //           backgroundColor: Colors.deepOrangeAccent,
                  //           label: Text("Delete Account", style: TextStyle(
                  //             fontFamily: 'NotoSansMono',
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 12.0,),),),
                  //       ),
                  //     ),
                  //     InkWell(splashColor: Colors.green,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: FloatingActionButton.extended(onPressed: ()
                  //         async{
                  //
                  //
                  //           await updateUserdata(usernameholder.text, emailholder.text, confirmpasswordcontroller.text);
                  //
                  //           }
                  //
                  //         , icon: Icon(Icons.save_sharp, color:
                  //         Colors.deepOrangeAccent,),
                  //           backgroundColor: Colors.cyan,
                  //           label: Text("Save Profile", style: TextStyle(
                  //             fontFamily: 'NotoSansMono',
                  //             fontWeight: FontWeight.w900,
                  //             fontSize: 12.0,),),),
                  //       ),
                  //     )
                  //
                  //   ],)


                ]),
          ),

        ),


      ),
    );
  }

  // Padding buildTextField(emailholder, passwordholder, bool ispassword) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 30.0),
  //     child: TextField(
  //       obscureText: ispassword ? showPassword : false,
  //       decoration: InputDecoration(
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         suffixIcon: ispassword ?
  //         IconButton(onPressed: () {
  //           setState(() {
  //             showPassword = !showPassword;
  //           });
  //         }, icon: Icon(Icons.remove_red_eye)
  //         ) : null,
  //         labelText: emailholder,
  //         hintText: passwordholder,
  //         hintStyle:
  //         TextStyle(fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
  //             fontSize: 24.0, color: Colors.black),
  //
  //       ),
  //     ),
  //   );


  Future updateUserdata(String username, String bio) async {
    setState(() {
      isLoading=true;
    });

      if (_selectedImage == null) {
        setState(() {
          isLoading=false;
        });
        showDialog(context: context, builder: (context) {
          return AlertDialog(
              content: Text("You have not Selected profile Image"),
              actions: [TextButton(onPressed: () async {
                Navigator.pop(context);
              }, child: Text("OKAY"))
              ]);
        });
      } else {
        final ref = FirebaseStorage.instance.ref().child('ImagePath');
        await ref.putFile(_selectedImage!);
        url = await ref.getDownloadURL();
        return await firebaseFirestore.collection("ultimateData").doc(user!.uid)
            .set({
          'Username': username,
          'Enail': loggedinuser.email,
          'ImagePath': url,
          'password': bio,
        }).then((value) => postDetailsToFirestore()).catchError((e) {
          print(e);
          showDialog(context: context, builder: (context) {
            return AlertDialog(content: Text(e.message.toString(),),
                actions: [TextButton(onPressed: () async {
                  setState(() {
                    isLoading=false;

                  });
                  Navigator.pop(context);
                }, child: Text("OKAY"))
                ]);
          });
        });
      
    }
  }


  postDetailsToFirestore() async
  {
    //calling firestore
    //call umodel
    // sending values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    usermodel UserModel = usermodel();

    //writing values
    UserModel.email = loggedinuser.email;
    UserModel.imagepath = url;
    UserModel.username = usernameholder.text;

    UserModel.password = confirmpasswordcontroller.text;

    await _userRef.push().set(UserModel.toMap());
    Fluttertoast.showToast(
      msg: "Profile Edited Successfully...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 30,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16,
    );
    Navigator.pushAndRemoveUntil(
        (context), MaterialPageRoute(builder: (context) => sidebar()),
            (route) => false);
  }
}

