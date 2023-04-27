import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_excellence_limited/model/usermodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ultimate_excellence_limited/pages/resetpassword.dart';
import 'package:ultimate_excellence_limited/pages/signup.dart';
import 'package:ultimate_excellence_limited/pages/home.dart';
import 'package:ultimate_excellence_limited/Counselor/counselorHome.dart';
import 'package:ultimate_excellence_limited/Mentor/mentorhome.dart';
import 'package:ultimate_excellence_limited/Sm/smHome.dart';
import 'package:ultimate_excellence_limited/Cm/cmHome.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class loginscreen extends StatefulWidget {

  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  bool isLoading = false;


  bool isvisible = true;

  String _userType = "Client";


  get onWillPop => null;
  final formKey = GlobalKey<FormState>();
  final mformKey = GlobalKey<FormState>();
  final usertypekey = GlobalKey<FormState>();


  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  DatabaseReference _userRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _userRef = FirebaseDatabase.instance.reference().child('clientData');
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
    return WillPopScope(

      onWillPop: () {
        exitDialogue();
        return Future.value(false);
      },

      child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: TextButton.icon(onPressed: () {
            exitDialogue();
          },
            icon: Icon(Icons.transit_enterexit_outlined, color: Colors.white70),
            label: Text
              ("EXIT",
              style: TextStyle(fontFamily: "NotoSansMono", fontWeight:
              FontWeight.w700, fontSize: 8.0, color: Colors.white),),),
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Container(
                  width: w,
                  height: h * 0.2,
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
                  margin: const EdgeInsets.only(left: 20, right: 20),
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
                      Text("Please Log Into Your Mental Health Account",
                          style: TextStyle(fontSize: 14.0, fontWeight:
                          FontWeight.w400, fontFamily: "NotoSansMono")),
                      SizedBox(height: 10),
                      Form(key: usertypekey,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusColor: Colors.brown,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.account_box, color: Colors.cyanAccent,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),),
                            labelStyle: TextStyle(fontSize: 20.0,
                                fontWeight:
                                FontWeight.w900,
                                fontFamily: "NotoSansMono",
                                color: Colors.lightGreenAccent),


                            labelText: "User Type",
                          ),
                          value: _userType,
                          items: [
                            "Client",
                            "Counselor",
                            "Mentor",
                            "Service Manager",
                            "Content Manager"
                          ]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                style: TextStyle(fontSize: 18.0, fontWeight:
                                FontWeight.w500, fontFamily: "NotoSansMono"),),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _userType = value!;

                              switch (_userType) {
                                case 'Client':
                                  _userRef =
                                      FirebaseDatabase.instance.reference()
                                          .child(
                                          'clientData');
                                  break;
                                case 'Counselor':
                                  _userRef =
                                      FirebaseDatabase.instance.reference()
                                          .child(
                                          'counselorData');
                                  break;
                                case 'Mentor':
                                  _userRef =
                                      FirebaseDatabase.instance.reference()
                                          .child(
                                          'mentorData');
                                  break;
                                case 'Service Manager':
                                  _userRef =
                                      FirebaseDatabase.instance.reference()
                                          .child(
                                          'smData');
                                  break;
                                case 'Content Manager':
                                  _userRef =
                                      FirebaseDatabase.instance.reference()
                                          .child(
                                          'cmData');
                                  break;
                                default:
                                  _userRef =
                                      FirebaseDatabase.instance.reference()
                                          .child(
                                          'clientData');
                                  break;
                              }
                            });
                          },
                          validator: (value) {
                            if (value! == 'Select Type of User') {
                              return "Alert! UserType Is required, Select";
                            }
                            return null;
                          },

                          icon: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.greenAccent,),
                          dropdownColor: Colors.cyan.shade300,

                        ),
                      ),

                      SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.blue[50],
                            boxShadow: [BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                spreadRadius: 5.0,
                                color: Colors.deepOrange.withOpacity(0.4)
                            )
                            ]
                        ),


                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            style: TextStyle(fontSize: 14,
                                fontFamily: 'NotoSansMono',
                                fontWeight: FontWeight.w400),
                            autofocus: false,
                            controller: emailcontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Provide your Email");
                              }
                              //email format validation
                              if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("INVALID Email!!, check your typing");
                              }
                              return null;
                            },

                            onSaved: (value) {
                              emailcontroller.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.deepOrange),
                                hintText: "Type your Email",
                                labelText: "Email",

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      color: Colors.indigoAccent,
                                      width: 1.5,
                                    )

                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                    )

                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                )
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.blue[50],
                            boxShadow: [BoxShadow(
                                blurRadius: 7,
                                offset: Offset(1, 1),
                                spreadRadius: 15.0,
                                color: Colors.deepOrange.withOpacity(0.2)
                            )
                            ]
                        ),
                        child: Form(
                          key: mformKey,
                          child: TextFormField(
                            style: TextStyle(fontSize: 14,
                                fontFamily: 'NotoSansMono',
                                fontWeight: FontWeight.w400),
                            autofocus: false,
                            controller: passwordcontroller,
                            validator: (value) {
                              RegExp regexp = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Kindly type in Your Password";
                              }
                              if (!regexp.hasMatch(value)) {
                                return "Password must not be less than 6 characters!";
                              }
                            },
                            onSaved: (value) {
                              passwordcontroller.text = value!;
                            },

                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_open, color: Colors.deepOrange,),
                                suffixIcon: GestureDetector(onTap: () {
                                  setState(() {
                                    isvisible = !isvisible;
                                  });
                                },
                                    child: Icon(
                                      isvisible ? Icons.visibility : Icons
                                          .visibility_off, size:
                                    30, color: Colors.cyan,)),
                                hintText: "Provide  your Password",
                                labelText: "Password",
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                      width: 1.5,
                                    )

                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        35),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                    )

                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(70)
                                )

                            ),
                            obscureText: isvisible,

                          ),
                        ),
                      ),


                    ],
                  ),

                  // margin: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 0.0),

                ),
                SizedBox(height: 2.0,),
                Row(
                    children: [
                      Expanded(child: Container(width: w,),),
                      TextButton(onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => resetpassword()));
                      }, child: Text(
                        "Forgot Your Password?,click Here >", style: TextStyle(
                          fontFamily: 'NotoSansMono',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color:
                          Colors.deepPurple),
                      )),
                    ]
                ),
                SizedBox(height: 10.0,),
                isLoading ? SpinKitSpinningLines(
                  size: 80, color: Colors.greenAccent,) :
                Container(
                    width: w * 0.9,
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.white,
                    ),

                    child: TextButton.icon(onPressed: () {
                      _login(
                          _userType, emailcontroller.text.toLowerCase().trim(),
                          passwordcontroller.text);
                    },
                      icon: Icon(
                          Icons.login_outlined, color: Colors.deepOrange),
                      label: Text
                        ("LOGIN", style: TextStyle(fontFamily: "NotoSansMono",
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Colors.deepOrange),)
                      ,
                    )),
                SizedBox(height: 3.0,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 2),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: Text(
                          "Don't have an Account?", style: TextStyle(
                            fontFamily: "NotoSansMono",
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0
                        ),),),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => signupscreen()));
                        }, child: Text(
                          "Create Account Here >>", style: TextStyle(
                            fontFamily: 'NotoSansMono',
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            color:
                            Colors.deepPurple),
                        )),
                      ]
                  ),

                ),

              ]


          ),
        ),
      ),
    );
  }


  Future<bool> exitDialogue() async
  {
    final shouldPop = await showDialog(context: context, builder: (context) =>


        AlertDialog(
          title: Text("Please Confirm"),
          content: Text("Do you Want to Exit The app?"),
          actions: [ElevatedButton(onPressed: () {
            SystemNavigator.pop();
          }, child: Text("Yes Exit")),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: Text("No I Want to Stay")),
          ],
        ),);

    return shouldPop ?? false;
  }

  /*void SignIn(String email, String password) async {
    if (formKey.currentState!.validate() && mformKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        // Login with email and password
        await _auth
            .signInWithEmailAndPassword(email: email, password: password).then((
            _) async {

        }).catchError((e) {
          print(e);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Login credentials/Network Error'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                      },
                      child: Text("OKAY"),
                    )
                  ],
                );
              });
        });

        // Get the user's data from the database
        // final dataSnapshot = await FirebaseDatabase.instance.ref().child(_userType).once();
        // final userId = usercredentials.user.id;

        final dataSnapshot = await FirebaseDatabase.instance
            .reference()
            .child(_userType)
            .onValue
            .listen((event) {
          if (event.snapshot.value != null) {
            Map<dynamic, dynamic> data = event.snapshot.value as Map<
                dynamic,
                dynamic>;


            // Check if user is approved
            if (data['status'] == 'approved') {
              // Navigate to respective userType page
              if (_userType == 'Client') {
                Fluttertoast.showToast(
                  msg: "Login Successful...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 24,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => home(),
                  ),
                );
              } else if (_userType == 'Mentor') {
                Fluttertoast.showToast(
                  msg: "Login Successful...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 24,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => mentorhome(),
                  ),
                );
              } else if (_userType == 'Counselor') {
                Fluttertoast.showToast(
                  msg: "Login Successful...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 24,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => counselorhome(),
                  ),
                );
              }
              else if (_userType == 'Service Manager') {
                Fluttertoast.showToast(
                  msg: "Login Successful...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 24,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => smHome(),),);
              }
              else if (_userType == 'Content Manager') {
                Fluttertoast.showToast(
                  msg: "Login Successful...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 24,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => cmHome(),),);
              }
            } else {
              setState(() {
                isLoading = false;
              });
              // Show an error message
              showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text('Error'),
                      content: Text('Your account is not approved yet.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OKAY'),
                        ),
                      ],
                    ),
              );
            }
          }
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        // Show an error message
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                  title: Text('DATABASE Error OCCURRED'),
                  content: Text(error.toString()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),),
                  ]),);
      }
    }
    setState(() {
      isLoading = false;
    });
  }*/

  void _login(String usertype, String email, String password) async {
    try {
      if (formKey.currentState!.validate() &&
          mformKey.currentState!.validate() &&
          usertypekey.currentState!.validate()) {
        formKey.currentState!.save();
        mformKey.currentState!.save();
        usertypekey.currentState!.save();
        setState(() {
          isLoading = true;
        });
        try {
          UserCredential userCredential = await
          _auth.signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text,

          );


          String? email = userCredential.user!.email;

          DatabaseEvent databaseEvent = await _userRef.orderByChild('email')
              .equalTo(email)
              .once();
          final DataSnapshot dataSnapshot = databaseEvent.snapshot;
          final Map<dynamic, dynamic> value = dataSnapshot.value as Map<
              dynamic,
              dynamic>;

          final String key = value.keys.first;

          final DatabaseEvent Event = await _userRef.child(key).once();
          final DataSnapshot keySnapshot = Event.snapshot;
          final Map<dynamic, dynamic>? values = keySnapshot.value as Map<
              dynamic,
              dynamic>?;

          if (keySnapshot.value != null && values != null &&
              values.containsKey('status')) {
            String status = values['status'] as String;


            if (status == 'approved') {
              switch (_userType) {
                case 'Client':
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => home()),
                  );
                  QuickAlert.show(context: context,
                      type: QuickAlertType.success,
                      title: "Success",
                      text: "LOG IN was SUCCESSFUL",
                      textColor: Colors.cyan,
                      titleColor: Colors.greenAccent,
                      borderRadius: 20,
                      autoCloseDuration: Duration(seconds: 3));
                  break;
                case 'Mentor':
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => mentorhome()),
                  );
                  QuickAlert.show(context: context,
                      type: QuickAlertType.success,
                      title: "Success",
                      text: "LOG IN was SUCCESSFUL",
                      textColor: Colors.cyan,
                      titleColor: Colors.greenAccent,
                      borderRadius: 20,
                      autoCloseDuration: Duration(seconds: 5));
                  break;
                case 'Service Manager':
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => smHome()),
                  );
                  QuickAlert.show(context: context,
                      type: QuickAlertType.success,
                      title: "Success",
                      text: "LOG IN was SUCCESSFUL",
                      textColor: Colors.cyan,
                      titleColor: Colors.greenAccent,
                      borderRadius: 20,
                      autoCloseDuration: Duration(seconds: 5));
                  break;
                case 'Counselor':
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => counselorhome()),
                  );
                  QuickAlert.show(context: context,
                      type: QuickAlertType.success,
                      title: "Success",
                      text: "LOG IN was SUCCESSFUL",
                      textColor: Colors.cyan,
                      titleColor: Colors.greenAccent,
                      borderRadius: 20,
                      autoCloseDuration: Duration(seconds: 5));
                  break;
                case 'Content Manager':
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => cmHome()),
                  );
                  QuickAlert.show(context: context,
                      type: QuickAlertType.success,
                      title: "Success",
                      text: "LOGGED IN was SUCCESSFUL",
                      textColor: Colors.cyan,
                      titleColor: Colors.greenAccent,
                      borderRadius: 20,
                      autoCloseDuration: Duration(seconds: 5));
                  break;
              }
            }
            else {
              setState(() {
                isLoading = false;
              });
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: "Wait Approval",
                confirmBtnText:
                "OKAY",
                text: "Your account is not approved yet",
                textColor: Colors.cyan,
                titleColor: Colors.red,);
            }
          }
          else {
            setState(() {
              isLoading = false;
            });
            QuickAlert.show(context: context,
                type: QuickAlertType.error,
                title: "Database Error",
                confirmBtnText:
                "OKAY",
                text: "Your Registration with us is not Recorded",
                textColor: Colors.cyan,
                titleColor: Colors.red,
                backgroundColor: Colors.deepPurple,
                confirmBtnColor: Colors.black87,
                borderRadius: 25);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            setState(() {
              isLoading = false;
            });
            QuickAlert.show(context: context,
                type: QuickAlertType.error,
                title: "user not found",
                confirmBtnText:
                "OKAY",
                text: "No user found with this Email and Password",
                textColor: Colors.cyan,
                titleColor: Colors.red,
                confirmBtnColor: Colors.lightBlue,
                borderRadius: 20);
          } else if (e.code == 'wrong-password') {
            setState(() {
              isLoading = false;
            });
            QuickAlert.show(context: context,
                type: QuickAlertType.error,
                title: "wrong-password",
                confirmBtnText: "Try Again",
                text: "Wrong password provided for This user",
                textColor: Colors.cyan,
                titleColor: Colors.red,
                confirmBtnColor: Colors.blueGrey,
                borderRadius: 20);
          }
        } catch (e) {
          setState(() {
            isLoading = false;
            emailcontroller.clear();
            passwordcontroller.clear();
          });
          QuickAlert.show(context: context,
              type: QuickAlertType.error,
              text: "Database ERROR " + e.toString(),
              cancelBtnText: 'Retry');
        }
      }

      setState(() {
        isLoading = false;

      });
    } on SocketException catch (e) {
      QuickAlert.show(context: context, type: QuickAlertType.error,
            title: "Connection Problem",text: "Check Your Internet And retry",titleColor: Colors.red);

      // Handle SocketException error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection Error'),
            content: Text(e.message.toString() +
                ' Failed to connect to server. Please check your internet connection and try again.'),
            actions: <Widget>[
              Flat3dButton(
                child: Text('OKAY'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}









