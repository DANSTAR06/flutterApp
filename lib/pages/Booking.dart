import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';


class BookingForm extends StatefulWidget {

  @override
  _BookingFormState createState() => _BookingFormState();

}

class _BookingFormState extends State<BookingForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference _bookingRef = FirebaseDatabase.instance.reference();


  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientEmailController = TextEditingController();
  final TextEditingController _clientPhoneController = TextEditingController();
  String _bookingType = 'Phone Call Session';
  String _serviceNameController = 'Counselling';
  bool isLoading = false;


 DateTime _selectedDate = DateTime.now();




  void _submitForm() {
    if (_formKey.currentState!.validate()) {

      final booking = Booking(
        serviceName: _serviceNameController,
        clientName: _clientNameController.text.trim(),
        clientEmail: _clientEmailController.text.trim(),
        clientPhone: _clientPhoneController.text.trim(),
        B_date: _selectedDate,
        bookingType: _bookingType,
      );

      _bookingRef.child('Bookings').push().set(
        booking.toMap(),
      ).then((_) {
        setState(() {
          isLoading = true;
        });
        QuickAlert.show(context: context, type: QuickAlertType.success,backgroundColor: Colors.black12,
            title: 'SUCCESSFUL',text: 'Booking Details Submitted Successfully',titleColor: Colors.redAccent,textColor: Colors.black,confirmBtnColor: Colors.red,
            confirmBtnText: 'OKAY',confirmBtnTextStyle: TextStyle(fontSize: 24.0,
              fontWeight:
              FontWeight.w900,
              fontFamily: "NotoSansMono",));
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        QuickAlert.show(context: context, type: QuickAlertType.error,backgroundColor: Colors.cyanAccent,
            title: 'Booking Failed',text: 'Error submitting booking: $error',titleColor: Colors.redAccent,textColor: Colors.black,confirmBtnColor: Colors.red,
        confirmBtnText: 'Retry',confirmBtnTextStyle: TextStyle(fontSize: 24.0,
              fontWeight:
              FontWeight.w600,
              fontFamily: "NotoSansMono",));

      });
      _clientNameController.clear();
      _clientEmailController.clear();
      _clientPhoneController.clear();

    }
  }
  Future<void> _selectDate(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(Duration(days: 30)),
      onConfirm: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.lightGreen,
          backgroundColor: Colors.orangeAccent,
          elevation: 0,
          title: Text('BOOKING',style: TextStyle(fontSize: 20,
              fontWeight:
              FontWeight.w900,
              fontFamily: "NotoSansMono",letterSpacing: 2.5,
              color: Colors.blueAccent)),
        ),
        body: SingleChildScrollView(

          child: Container(
            height: h,
            width: w,
            child: Padding(

              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Select Appointment Type',style: TextStyle(fontSize: 16.0,
                          fontWeight:
                          FontWeight.w800,
                          fontFamily: "NotoSansMono",
                          color: Colors.cyan[200]),),

                      SizedBox(height: 15,),

                      DropdownButtonFormField(

                        decoration: InputDecoration(
                          focusColor: Colors.brown,
                          fillColor: Colors.white,
                          prefixIcon: Icon(CupertinoIcons.person_2_fill,
                            color: Colors.amber,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),),
                          labelStyle: TextStyle(fontSize: 14.0,
                              fontWeight:
                              FontWeight.w600,
                              fontFamily: "NotoSansMono",
                              color: Colors.white),

                          labelText: "Booking Type",
                        ),

                        value: _bookingType,
                        onChanged: (String? value) {
                          setState(() {
                            _bookingType = value!;
                          });
                        },
                        items: <String>[
                          'Phone Call Session',
                          'Chat Session',
                          'Video Call',
                          'Physical Meeting Session'
                        ]
                            .map<DropdownMenuItem<String>>(
                              (value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 14.0,
                                  fontWeight:
                                  FontWeight.w800,
                                  fontFamily: "NotoSansMono"),),
                            );
                          },
                        ).toList(),
                        dropdownColor: Colors.cyan.shade500,
                        icon: Icon(
                          CupertinoIcons.arrow_down_circle_fill, size: 22, color: Colors.pink,),
                      ),


                      SizedBox(height: 10.0),

                      Text('Select Service Type',style: TextStyle(fontSize: 16.0,
                          fontWeight:
                          FontWeight.w800,
                          fontFamily: "NotoSansMono",
                          color: Colors.cyan[200]),),
                      SizedBox(height: 10,),


                      SingleChildScrollView(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusColor: Colors.brown,
                            fillColor: Colors.white,
                            prefixIcon: Icon(CupertinoIcons.book_circle_fill,
                              color: Colors.amber,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),),
                            labelStyle: TextStyle(fontSize: 14.0,
                                fontWeight:
                                FontWeight.w500,
                                fontFamily: "NotoSansMono",
                                color: Colors.white),


                            labelText: "Service Name",
                          ),

                          value: _serviceNameController,
                          onChanged: (String? value) {
                            setState(() {
                              _serviceNameController = value!;
                            });
                          },
                          items: <String>[
                            'Counselling', 'Life Coaching', 'Corporate Training', 'Motivational Talks', 'Entrepreneurial Training ','Career Training',
                            'Leadership training',
                            'School Mentorship Program',
                          ]
                              .map<DropdownMenuItem<String>>(
                                (value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 12.0,
                                    fontWeight:
                                    FontWeight.w700,
                                    fontFamily: "NotoSansMono"),),
                              );
                            },
                          ).toList(),
                          dropdownColor: Colors.cyan.shade500,
                          icon: Icon(CupertinoIcons.list_number_rtl, size: 16,
                            color: Colors.pink[600],),
                        ),
                      ),

                      SizedBox(height: 16.0),

                      TextFormField(
                        style: TextStyle(fontSize: 16.0,
                            fontWeight:
                            FontWeight.w700,
                            fontFamily: "NotoSansMono"),
                        controller: _clientNameController,
                        decoration: InputDecoration(prefixIcon: Icon(
                          CupertinoIcons.profile_circled, size: 24,
                          color: Colors.amber[300],),
                          labelText: 'Client Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),


                      SizedBox(height: 25.0),


                      TextFormField(
                        style: TextStyle(fontSize: 16.0,
                            fontWeight:
                            FontWeight.w700,
                            fontFamily: "NotoSansMono"),
                        controller: _clientEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(prefixIcon: Icon(
                          CupertinoIcons.mail_solid, size: 20,
                          color: Colors.amber[100],),
                          labelText: 'Client Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20,),

                      TextFormField(

                        validator: (value) {
                          RegExp regexp = new RegExp('^254+[0-9]');
                          if (value!.isEmpty) {
                            return "Kindly type in Your Phone Number";
                          }

                          if (value.length < 10 || value.length > 12) {
                            return "Provide a Valid Phone Number";
                          }

                          if (!regexp.hasMatch(value)) {
                            return "Phone Number  format should be +254 then 9digits number";
                          }
                        },
                        controller: _clientPhoneController,
                        autofocus: false,
                        onSaved: (value) {
                          _clientPhoneController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 14,
                            fontFamily: 'NotoSansMono',
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone_android_outlined,
                              color: Colors.black,size: 22,),
                            hintText: "Phone Number",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                )

                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 1.5,
                                )

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),


                      ),
                      SizedBox(height: 25,),

                      Text('Select Date And Time',style: TextStyle(fontSize: 18.0,
                          fontWeight:
                          FontWeight.w800,
                          fontFamily: "NotoSansMono",
                          color: Colors.cyan[400]),),

                      TextButton.icon(
                        label:
                         Text( _selectedDate != null
                            ? _selectedDate.toIso8601String().substring(0, 16)
                            : 'Select a date and time',style: TextStyle(fontSize: 24.0,
                            fontWeight:
                            FontWeight.w900,letterSpacing: 2.0,
                            fontFamily: "NotoSansMono",
                            color: Colors.blue[900]),),
                        onPressed: () => _selectDate(context), icon: Icon(CupertinoIcons.calendar_badge_plus,size: 28,),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Flat3dButton (color: Colors.blueGrey,padding: EdgeInsets.all(10),
                          child: Text('Submit booking',style: TextStyle(fontSize: 24.0,
                            fontWeight:
                            FontWeight.w700,letterSpacing: 2.0,
                            fontFamily: "NotoSansMono",),),  
                          onPressed: _submitForm
                        ),
                      ),


                    ]),
              ),
            ),
          ),
        )
    );
  }
}
class Booking {
  final String serviceName;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
 DateTime B_date;

  final String bookingType;


  Booking({
    required this.serviceName,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,

    required this.bookingType, required this.B_date,
  });

  Map<String, dynamic> toMap() {
    return {

      'serviceName': serviceName,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'bookingType': bookingType,
      'bookingDate': B_date.toIso8601String().substring(0, 16),

    };
  }

  factory Booking.fromMap(Map<String, dynamic> map, String id) {
    return Booking(
      serviceName: map['serviceName'],
      clientName: map['clientName'],
      clientEmail: map['clientEmail'],
      clientPhone: map['clientPhone'],
      B_date: map['bookingDate'],
      bookingType: map['bookingType'],
    );
  }

}




