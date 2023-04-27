import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

import '../model/appoinment.dart';
import 'Booking.dart';

class appointmentlist extends StatelessWidget {

  appointmentlist(
      { required this.Appointments, required this.onCancel});

  final List<appointment> Appointments;
  final Function(appointment) onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(

        itemCount: Appointments.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(thickness: 5, color: Colors.purpleAccent,),
        itemBuilder: (context, index) {
          final appointment = Appointments[index];
          return ListTile(leading: Text(
            (index + 1).toString(), style: GoogleFonts.aladin(fontSize: 24),),
            title: Text("Schedule Date And Time |: " +
                DateFormat.yMMMMd().add_jm().format(appointment.dateTime),
              style: GoogleFonts.alumniSans(fontSize: 24),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Text("Type of Service Booked | :" + appointment.serviceName,
                  style: GoogleFonts.aladin(fontSize: 18),),
                SizedBox(height: 10,),
                Text("Type Of session Booked | :" + appointment.bookingType,
                  style: GoogleFonts.akayaTelivigala(fontSize: 16),),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.cancel, size: 30, color: Colors.redAccent,),
              onPressed: () => onCancel(appointment),
            ),
          );
        },
      ),
    );
  }}
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<appointment> _appointments = [];

  @override
  void initState() {
// TODO: fetch appointments from Firebase database
    super.initState();
    _loadAppointments();
  }
  void _loadAppointments() async {
    FirebaseAuth _auth =FirebaseAuth.instance;
    String? email = _auth.currentUser!.email;

    DatabaseReference appointmentsRef = FirebaseDatabase.instance.reference()
        .child('Bookings');
    Query bookingsQuery = appointmentsRef.orderByChild('clientEmail').equalTo(email);
// Attach a value event listener to the database reference
    bookingsQuery.onValue.listen((DatabaseEvent event) {
      // Handle the event
     // DataSnapshot snapshot = event.snapshot;
     // Map<dynamic, dynamic> bookingsMap = snapshot.value as Map<dynamic, dynamic>;

      // Do something with the bookingsMap
    /* onError: (Object? error) {
      // Handle errors
      print('Error fetching bookings: $error');
    });*/


      final appointments = <appointment>[];
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      if (data != null) {
        data.forEach((key, value) {
          final Appointment = appointment(
            userId: _auth.currentUser!.uid,
            clientName: value['clientName'],
            serviceName: value['serviceName'],
            phone: value['clientPhone'],
            email: value['clientEmail'],
            bookingType: value['bookingType'],
            dateTime: DateTime.parse(value['bookingDate']),

          );
          appointments.add(Appointment);
        });
      }
      setState(() {
        _appointments = appointments;
      });
    }, onError: (Object? error) {
      // Handle errors
      QuickAlert.show(context: context, type: QuickAlertType.error,title: "Error!",text: 'No Data or invalid ID:');
      print('Error fetching bookings: $error');});
  }


// TODO: delete appointment from Firebase database

  Future<void> cancelAppointment(appointment appointment) async {
    try {
      DatabaseReference appointmentRef = FirebaseDatabase.instance.reference().child('Bookings/$appointment');
      await appointmentRef.remove().then((_) {

        setState(() {
          QuickAlert.show(context: context, type: QuickAlertType.warning,title: "Confirm Delete",text: "Delete This Schedule",
              onConfirmBtnTap:(){_appointments.removeWhere((appointment) => appointment.clientName == appointment);} );

        });
      });
    } catch (e) {
      // Handle the error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.purpleAccent,
        title: Text('My Schedule'),
      ),
      body: _appointments.isEmpty
          ? Center(child: Text('No appointments scheduled'))
          : appointmentlist(
          Appointments: _appointments,
          onCancel: (appointment) async {
    await cancelAppointment(appointment);
    }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingForm(),
            ),
          );
        },
        child: Icon(Icons.add,size: 60,color: Colors.purpleAccent,),
      ),
    );
  }
}




