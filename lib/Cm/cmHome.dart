import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/Cm/ResourcePage.dart';
import 'package:ultimate_excellence_limited/Cm/contenthome.dart';
import 'package:ultimate_excellence_limited/Cm/postResource.dart';
import '../pages/login.dart';


class cmHome extends StatefulWidget {
  const cmHome({Key? key}) : super(key: key);

  @override
  State<cmHome> createState() => _cmHomeState();
}
FirebaseAuth _auth =FirebaseAuth.instance;

class _cmHomeState extends State<cmHome> {
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(backgroundColor: Colors.orangeAccent,
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
      }, child: Text("Yes Log Out please",style: TextStyle(fontFamily: "NotoSnasMono",
      fontSize: 18,fontWeight: FontWeight.w900),))],
      );
      });
      },
      icon: Icon(Icons.logout,size: 20,color: Colors.red[900],),label: Text("Log out",
        style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16.0,fontFamily:
        "NotoSansMono",color: Colors.indigo
        ),),
    ),],
        centerTitle: false,
        title: Text('CONTENT MANAGER!'),elevation: 0,
      ),
      body: SizedBox(
      height: h,width: w,
      child: Container(

      child: GridView.count(crossAxisCount: 2,


      primary: false,
      padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
      crossAxisSpacing: 5,
      mainAxisSpacing: 8,
      children: <Widget>[

      InkWell(splashColor: Colors.red,onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResourceTable()));},
      child: Card( color: Colors.red[800],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(100)),
    child: Column(
    children:<Widget>[
    Image(image: AssetImage("assets/digitlib.jpg"),width: 98,height: 100,),
    SizedBox(height: 10.0,),
    Text("E-L Resources", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14.0,fontFamily:
    "NotoSansMono",color: Colors.white),
    ),
    ],

    ),

    ),
    ),],
    ),),
    ),);
  }
}
