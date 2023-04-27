import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/ourBooks/ourbooks.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
import 'package:ultimate_excellence_limited/pages/resourcepage.dart';
import 'package:ultimate_excellence_limited/pages/schedules.dart';
import 'package:ultimate_excellence_limited/pages/selfcare.dart';
import 'package:ultimate_excellence_limited/pages/servicescreen.dart';
import 'package:ultimate_excellence_limited/pages/sidebar.dart';

import '../books/bookList.dart';
import 'Booking.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.red[100],
      drawer: sidebar(),
      appBar: AppBar(title:Text("UEMA",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30.0,fontFamily:
      "NotoSansMono",
          letterSpacing:10.0),),
        centerTitle: true,backgroundColor: Colors.orange[600],
        elevation:0.0,
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
    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
    "NotoSansMono",color: Colors.indigo
        ),),
          ),
        ],),



      body: SizedBox(
        height: h,width: w,
        child: Container(

          child: GridView.count(crossAxisCount: 2,


            primary: false,
            padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
            crossAxisSpacing: 5,
            mainAxisSpacing: 8,
            children: <Widget>[

              InkWell(splashColor: Colors.green,onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));},
                child: Card( color: Colors.red[800],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/mental.png"),width: 80,height: 90,),
                      SizedBox(height: 1.0,),
                      Text("MENTAL HEALTH", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
              InkWell(splashColor: Colors.green,onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulePage()));
              },
                child: Card( color: Colors.brown[900],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/schedul.png"),width: 80,height: 90,),
                      SizedBox(height: 2.0,),
                      Text("MY SCHEDULE", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
              InkWell(splashColor: Colors.green,onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingForm()));
              },
                child: Card( color: Colors.purple[600],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/BOOK.png"),width: 80,height: 90,),
                      SizedBox(height: 2.0,),
                      Text("BOOKINGS", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
              InkWell(splashColor: Colors.green,onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfCareQuizPage()));},
                child: Card( color: Colors.pinkAccent,shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/assessment.png"),width: 80,height: 90),
                      SizedBox(height: 2.0,),
                      Text("SELFCARE", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
              InkWell(splashColor: Colors.green,onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>servicescreen()));},
                child: Card( color: Colors.indigo[900],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/service.png"),width: 80,height: 90,),
                      SizedBox(height: 2.0,),
                      Text("SERVICES", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
              InkWell(splashColor: Colors.green,onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookReadingPage()));

              },
                child: Card( color: Colors.green[800],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/ffbook.jpg"),width: 80,height: 110,),
                      SizedBox(height: 2.0,),
                      Text("OUR BOOKS", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
              InkWell(splashColor: Colors.green,onTap: (){Navigator.push(context, MaterialPageRoute
                (builder: (context)=>ResourcePage()));},
                child: Card( color: Colors.orange[600],shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(70)),
                  child: Column(
                    children:<Widget>[
                      Image(image: AssetImage("assets/resources.png"),width: 80,height: 90),
                      SizedBox(height: 2.0,),
                      Text("RESOURCES", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14.0,fontFamily:
                      "NotoSansMono",color: Colors.white),
                      ),
                    ],

                  ),

                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
