import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/model/usermodel.dart';
import 'package:ultimate_excellence_limited/pages/aboutUs.dart';
import 'package:ultimate_excellence_limited/pages/home.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
import 'package:ultimate_excellence_limited/pages/settings.dart';
import 'package:ultimate_excellence_limited/pages/userprofile.dart';
class sidebar extends StatefulWidget {
  const sidebar({Key? key}) : super(key: key);

  @override
  State<sidebar> createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  User? user =FirebaseAuth.instance.currentUser;
  usermodel loggedinuser= usermodel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("ultimateData").doc(user!.uid).get()
    .then((value)=>setState(()=>this.loggedinuser=usermodel.fromMap(value.data())));

    }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.lime[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${loggedinuser.username}",style: TextStyle(fontFamily: "NotoSansMono",fontWeight: FontWeight.w900,
                  fontSize: 22.0),),
              accountEmail: Text("${loggedinuser.email}",
                  style: TextStyle(fontFamily: "NotoSansMono",fontWeight: FontWeight.w600,
                      fontSize: 14.0,color: Colors.orangeAccent)),
              currentAccountPicture: CircleAvatar(

                child: ClipOval(

                  child: Image.network("${loggedinuser.imagepath}",fit: BoxFit.cover,height: 130,width: 130,),

                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(

                    image: AssetImage("assets/moon.jpg")
                    ,fit: BoxFit.fill,
                  )
              ),

            ),
            SizedBox(height: 15.0,),
            ListTile(
                leading: Icon(CupertinoIcons.home,size: 30.0,color: Colors.deepOrange,),
                title:Text("Home",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),hoverColor:
            Colors.orangeAccent,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));

                }
            ),
            SizedBox(height: 15.0,),
            ListTile(
                leading: Icon(CupertinoIcons.profile_circled,size: 30.0,color: Colors.deepOrange,),
                title:Text("Profile",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
                onTap: ()
                {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>userprofile()));}
            ),
            SizedBox(height: 15.0,),
            ListTile(
                leading: Icon(CupertinoIcons.bell_fill,size: 30.0,color: Colors.deepOrange,),
                title:Text("Notifications",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
                trailing: ClipOval(
                  child: Container(color: Colors.red,child: Center(
                    child: Text("2",style: TextStyle(fontSize: 16,fontFamily:
                    "NotoSnasMono",fontWeight: FontWeight.w400,color: Colors.white),),
                  ),height: 25,width: 25,),
                ),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                }
            ),
            Divider(color: Colors.black,thickness: 1.0,),
            ListTile(
                leading: Icon(CupertinoIcons.settings_solid,size: 30.0,color: Colors.deepOrange,),
                title:Text("Settings",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>settings()));
                }
            ),
            SizedBox(height: 15.0,),
            ListTile(
                leading: Icon(CupertinoIcons.smiley,size: 30.0,color: Colors.deepOrange,),
                title:Text("About Us",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>aboutUs()));
                }
            ),
            SizedBox(height: 15.0,),
            ListTile(
                leading: Icon(CupertinoIcons.hand_thumbsup_fill,size: 30.0,color: Colors.deepOrange,),
                title:Text("FeedBacks",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                }
            ),
            Divider(color: Colors.redAccent,thickness: 2.0,),
            ListTile(
                leading: Icon(CupertinoIcons.return_icon,size: 30.0,color: Colors.deepOrange,),
                title:Text("Logout",style:
                TextStyle(fontFamily: "NotoSnasMono",fontSize: 20,fontWeight: FontWeight.w900),),
                onTap: ()async{
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
                    ),content: Text("Confirm You want to LOog out?",style:
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
                }
            ),

          ],

        ),
      ),
    );
  }
}
