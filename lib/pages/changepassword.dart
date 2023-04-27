import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
class changePass extends StatefulWidget {
  const changePass({Key? key}) : super(key: key);

  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  @override
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  bool ispasswordvisible=true;

  final TextEditingController newpasswordcontoller = new TextEditingController();

  final currentuser = FirebaseAuth.instance.currentUser;

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
          actions: [
          TextButton.icon( onPressed:(){
    showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(title: Row(children: [Padding(
    padding: const EdgeInsets.all(10.0),
    child: Icon(Icons.warning_amber,color: Colors.redAccent,
    ),
    ),Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text("Log Out!",style: TextStyle(fontFamily: "NotoSnasMono",
    fontSize: 20,fontWeight: FontWeight.w900),),
    ),
    ],
    ),content: Text("Confirm You want to Log out?",style:
    TextStyle(fontFamily: "NotoSnasMono",fontSize: 16,fontWeight: FontWeight.w600)),
    actions: [TextButton(onPressed: ()async{
    Navigator.pop(context);
    }, child: Text("No stay In",style: TextStyle(fontFamily: "NotoSnasMono",
    fontSize: 20,fontWeight: FontWeight.w900),),),
    TextButton(onPressed: ()async{
    Navigator.pop(context);
    await _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginscreen()));
    }, child: Text("Yess Log Out please",style: TextStyle(fontFamily: "NotoSnasMono",
    fontSize: 18,fontWeight: FontWeight.w900),))],
    );
    });
    },
  icon: Icon(Icons.logout,size: 20,color: Colors.red[900],),label: Text("Log out",
  style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
  "NotoSansMono",color: Colors.indigo
  ),),
  ),]
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
                "Provide New Password",
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

                  decoration: InputDecoration(suffixIcon: GestureDetector(onTap: (){
                    setState(() {
                      ispasswordvisible =! ispasswordvisible;
                    });
                  },
                      child: Icon(ispasswordvisible ? Icons.visibility : Icons.visibility_off
                        ,size: 25,color: Colors.brown,)),
                      labelText: 'New Password',
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
                      fontFamily: 'NotoSansMono',color: Colors.white,
                      fontWeight: FontWeight.w600),
                  autofocus: false,
                  controller: newpasswordcontoller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kindly New Password Can not be Empty";
                    }
                    if (value.length <6)
                      {
                      return ("INVALID Password!!, It Must Contain 6 or more character");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newpasswordcontoller.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  obscureText: ispasswordvisible,


                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: ElevatedButton.icon(onPressed: () {
                if(formKey.currentState!.validate()){


                       changepassword(newpasswordcontoller.text);


              }},
                  style:ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      backgroundColor: Colors.cyan),
                  icon: Icon(
                      CupertinoIcons.doc_checkmark_fill, color: Colors.white,size: 30,),
                  label: Text
                    ("Save New Password",
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

 changepassword(String newpas) async{
    try{
      await currentuser!.updatePassword(newpas);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginscreen()));
      SnackBar(content: Text("Password Changed! Log in Using the New Password"),
        duration: Duration(seconds: 5),backgroundColor: Colors.cyan,);

    }catch(err){
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text(err.toString(),),
        actions: [TextButton(onPressed: () async {
          Navigator.pop(context);
        }, child: Text("OKAY"))],);
      });
    }
    }
 }


