import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/pages/changepassword.dart';
import 'package:ultimate_excellence_limited/pages/home.dart';

import 'deleteAccount.dart';
import 'login.dart';
class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.limeAccent[600],
        appBar: AppBar(backgroundColor:Colors.transparent,leading: IconButton(onPressed: () {
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => home()));
          }
        },
          icon: Icon(CupertinoIcons.back, color: Colors.white,size: 25,),),
          elevation: 1,

        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(splashColor: Colors.green,onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
                deleteAccount()));},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(CupertinoIcons.delete,size: 40,color: Colors.redAccent,),
                      SizedBox(width: 5,),Text("Delete Account",
                        style: TextStyle(
                            fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                            fontSize: 20.0, color: Colors.purple)),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Divider(height: 2,thickness: 2,color: Colors.blueGrey),
                SizedBox(height: 40),
                InkWell(splashColor: Colors.redAccent,onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>changePass()));
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(CupertinoIcons.keyboard_chevron_compact_down,size: 40,color: Colors.redAccent,),
                      SizedBox(width: 5,),Text("Change Password",
                          style: TextStyle(
                              fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                              fontSize: 20.0, color: Colors.purple)),

                    ],
                  ),
                ),
                SizedBox(height: 40),
                Divider(height: 2,thickness: 2,color: Colors.blueGrey),
                SizedBox(height: 40,),
                InkWell(splashColor:Colors.redAccent,onTap: (){
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
    );});
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(CupertinoIcons.return_icon,size: 40,color: Colors.redAccent,),
                      SizedBox(width: 5,),Text("Log Out",
                          style: TextStyle(
                              fontFamily: 'NotoSansMono', fontWeight: FontWeight.w700,
                              fontSize: 22.0, color: Colors.purple)),

                    ],
                  ),
                ),
                SizedBox(height: 40),
                Divider(height: 2,thickness: 2,color: Colors.blueGrey),
              ],
            ),
          ),


        )
    );
  }
}
