import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_excellence_limited/pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ultimate_excellence_limited/pages/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(splash:
    Stack(


      fit: StackFit.expand,


      children:<Widget> [

        Container(
          
          height: h*0.05,
          width: w,
          child: Column(
            children: [

              Expanded(flex: 2,
                  child: Container(child:
                  Lottie.network("https://assets9.lottiefiles.com/packages/lf20_ggregfua/Yoga guy/Yoga Guy.json"),)),
              Expanded(flex: 2,
                child: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                  CircleAvatar(radius: 35,child:
                  ClipOval(child: Image.asset("assets/certifiedlifecoach.jpg",
                    fit: BoxFit.cover,height: 70,width: 90,))),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("WELCOME TO ULTIMATE EXCELLENCE MOBILE APPLICATION"
                      ,style: TextStyle(color: Colors.yellow,fontFamily: 'NotoSansMono',
                          fontWeight: FontWeight.w500,fontSize: 12.0),),
                  ),
                ],), ),
              ),
              Expanded(flex: 1, child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SpinKitSpinningLines(color: Colors.yellowAccent,size: 50,),
                  ),
                  SizedBox(height: 20,),
                  Text("YOUR MENTAL HEALTH STATE MATTERS THE MOST..." ,style: TextStyle(color: Colors.lightGreenAccent,fontFamily: 'NotoSansMono',
                      fontWeight: FontWeight.w900,fontSize: 12.0),),
                ],
              ),),



            ],
          ),
        )],
    ),
        backgroundColor: Colors.pink,duration: 7000,splashIconSize:700,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.topToBottom,
        nextScreen: loginscreen());
  }
}


