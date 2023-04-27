import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
class deleteAccount extends StatefulWidget {
  const deleteAccount({Key? key}) : super(key: key);

  @override
  State<deleteAccount> createState() => _deleteAccountState();
}

class _deleteAccountState extends State<deleteAccount> {
  final formKey = GlobalKey<FormState>();
  final pasformKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;


  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passcontroller = new TextEditingController();

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
      backgroundColor: Colors.orange[800],
      appBar: AppBar(title: Text("UEMA", style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 24.0, fontFamily:
      "NotoSansMono",
          letterSpacing: 1.5),),
        centerTitle: true, backgroundColor: Colors.deepOrangeAccent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/ultimate.jpg"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Provide your Email and Password for the account you want to delete",
                style: TextStyle(fontFamily: "NotoSansMono",
                    fontWeight: FontWeight.w900, fontSize: 16.0),),
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(70)),),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: TextFormField(

                  decoration: InputDecoration(labelText: 'Email',hintText: "example@gmail.com",
                      prefixIcon:Icon( Icons.email_outlined,color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(70),
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                        ),

                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),

                  style: TextStyle(fontSize: 14,
                      fontFamily: 'NotoSansMono', color: Colors.white,
                      fontWeight: FontWeight.w600),
                  autofocus: false,
                  controller: emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kindly Email is Required!";
                    }
                    if (!RegExp(
                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("INVALID Email Format!!, check your typing");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailcontroller.text = value!;
                  },

                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(key: pasformKey,
                  child: TextFormField(
                      style: TextStyle(fontSize: 14,
                      fontFamily: 'NotoSansMono',
                      fontWeight: FontWeight.w400),
                      autofocus: false,
                      controller: passcontroller,
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
                        passcontroller.text = value!;
                      },
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_open, color: Colors.white,),
                          hintText: "Provide  your Password",
                          labelText: "Password",
                          border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(70)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(70),
                              borderSide: BorderSide(
                                color: Colors.indigo,
                                width: 1.5,
                              )
                          )
                      )


                  )),
            ),
            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.fromLTRB(40,10,40,10),
              child: FloatingActionButton.extended(onPressed: () {
                _deleteAccount(emailcontroller.text, passcontroller.text);
              },
                  backgroundColor: Colors.cyan,

                  icon: Icon(
                      CupertinoIcons.delete_simple, color: Colors.redAccent,size: 30,),
                  label: Text
                    ("Click to Delete Acount",
                    style: TextStyle(fontFamily: "NotoSansMono",
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                        color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

  void _deleteAccount(String email, String password) async {
    if (formKey.currentState!.validate() &&
        pasformKey.currentState!.validate()) {
      User? user = await _auth.currentUser;
      AuthCredential authCredential = EmailAuthProvider.credential(
          email: email, password: password);

      await user?.reauthenticateWithCredential(authCredential).then((value) {
        value.user?.delete().then((res) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginscreen()));
          SnackBar(content: Text("Account Deleted Successfully!"),
            duration: Duration(seconds: 7),
            backgroundColor: Colors.purple,
            elevation: 25,);
        });
      }).catchError((e) {
        print(e);
        showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text(e.message.toString(),),
            actions: [TextButton(onPressed: () async {
              Navigator.pop(context);
            }, child: Text("OKAY"))
            ],);
        });
      });
    }
  }

}
