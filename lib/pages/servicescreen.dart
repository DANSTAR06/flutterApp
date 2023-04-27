import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/servicemodel.dart';
import 'Booking.dart';

class servicescreen extends StatefulWidget {
  const servicescreen({Key? key}) : super(key: key);

  @override
  State<servicescreen> createState() => _servicescreenState();
}

class _servicescreenState extends State<servicescreen> {
  List<service> services = [
    service(service_name: "Counselling", imageicon: 'assets/counselling.png'),
    service(service_name: "Life Coaching", imageicon: 'assets/lifecoach.png'),
    service(service_name: "Corporate Training", imageicon: 'assets/corporateT.png'),
    service(service_name: "Motivational Talks", imageicon: 'assets/motivation.png'),
    service(service_name: "School Mentorship Programs", imageicon:'assets/schoolmp.png'),
    service(service_name: "Team And Capacity Building", imageicon: 'assets/life.png'),
    service(service_name: "Entrepreneurial Training", imageicon: 'assets/entrepren.png'),
    service(service_name: "Career Training", imageicon: 'assets/Careeer.png'),
    service(service_name: "Leadership training", imageicon: 'assets/leadership.png'),
  ];

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
      backgroundColor: CupertinoColors.systemPink,
      appBar: AppBar(backgroundColor: Colors.pinkAccent,title: Text("Our Services",style: GoogleFonts.aBeeZee(color: Colors.black,
      fontSize: 24,fontWeight: FontWeight.w700),),elevation: 0,centerTitle: true,),

      body:ListView.builder( itemCount: services.length,
          itemBuilder: (context, index) {

            final listservice = services[index];
            listservice.imageicon != null;

              return InkWell(splashColor: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 10),
                  child: ListTile(onTap: () {},
                    leading:
                    Image.asset(listservice.imageicon!),
                    title: Text(listservice.service_name.toString(),
                        style: GoogleFonts.actor(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    //subtitle: Text(book.author,style: GoogleFonts.arsenal(fontWeight: FontWeight.w500,fontSize: 14),),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to booking page with selected service
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingForm()));
                      },
                      child: Text("Book Services", style: GoogleFonts.actor(
                          color: Colors.cyanAccent, fontSize: 12),),
                    ),),
                ),
              );
            }));
  }
}
