import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:ultimate_excellence_limited/model/booksmodel.dart';
import '../pages/home.dart';
import 'bookReading.dart';
import 'ourbooks.dart';

class BookPurchaseForm extends StatefulWidget {
final booksmodel book;
  const BookPurchaseForm({required this.book, Key? key, }) : super(key: key);


  @override
  _BookPurchaseFormState createState() => _BookPurchaseFormState();
}

class _BookPurchaseFormState extends State<BookPurchaseForm> {


  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mpesaCodeController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isPreviewing = false;
  bool _isPurchasing = false;
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _mpesaCodeController.dispose();
    _paymentDateController.dispose();
    _amountController.dispose();
    super.dispose();
  }


late booksmodel? _selectedBook;

  late String usernum;
  @override
  void initState() {

    super.initState();
    _selectedBook = widget.book;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      usernum = user.uid;
    }
  }
  Future<bool> hasUserPurchasedBook(String bookId) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    final DatabaseEvent Event = await dbRef.child('userBooks').child(bookId).once();
    final DataSnapshot keySnapshot = Event.snapshot;
    final Map<dynamic, dynamic>? values = keySnapshot.value as Map<
        dynamic,
        dynamic>?;

      return keySnapshot.value != null;

  }

  @override
  Widget build(BuildContext context) {

    //final _selectedBook = ModalRoute.of(context)?.settings.arguments as booksmodel;

    FutureBuilder<bool>(
      future: hasUserPurchasedBook(widget.book.fullContentUrl),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitFadingCircle(
            color: Colors.pink,
            size: 90.0,
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.data == true)
        {
          return bookReading(book: _selectedBook!);
        } else {
           // your book model

          return BookPurchaseForm(book: _selectedBook!);
        }
      },
    );
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(title: Text("BUYING BOOKS", style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 18.0, fontFamily:
      "NotoSansMono",
          letterSpacing: 5.0),),
        leading: GestureDetector(child: Icon(Icons.arrow_back,), onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BookReadingPage()));
        }),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,),

      body:
      SingleChildScrollView(
        child: Container(width: w, height: h,
          child: Form(
            key: _formKey,
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    style: TextStyle(fontFamily: "NotoSansMono", fontWeight:
                    FontWeight.w700, fontSize: 14.0, color: Colors.purple),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Client Name',
                        prefixIcon: Icon(
                          Icons.person, color: Colors.red,)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a client name';
                      }
                      return null;

                    },
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(

                  style: TextStyle(fontFamily: "NotoSansMono", fontWeight:
                  FontWeight.w700, fontSize: 14.0, color: Colors.purple),
                  textInputAction: TextInputAction.next,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone_android, color: Colors.orangeAccent,)),
                  validator: (value) {
                    RegExp phoneNumberRegex = RegExp(r'^\d{1,3}\d{9,}$');
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (!phoneNumberRegex.hasMatch(_phoneController.text)) {
                      return 'Wrong fomart. Phone number to start with 254 then 9-digits';
                    }
                    if (_phoneController.text.length > 12) {
                      return 'Invalid Number input';
                    }
                    return null;

                  },
                ), SizedBox(height: 10,),

                SizedBox(height: 8,),
                TextFormField(
                  style: TextStyle(fontFamily: "NotoSansMono", fontWeight:
                  FontWeight.w700, fontSize: 14.0, color: Colors.purple),
                  textInputAction: TextInputAction.next,
                  controller: _mpesaCodeController,
                  decoration: InputDecoration(labelText: 'M-pesa Payment Code',
                      prefixIcon: Icon(Icons.abc_outlined, color: Colors.red,)),

                  validator: (value) {
                    RegExp mpesaCodeRegex = RegExp(
                        r'^[A-Z][0-9]{2}[A-Z]{2}[A-Z0-9]{5}$');

                    if (!mpesaCodeRegex.hasMatch(_mpesaCodeController.text)) {
                      return ('Mpesa code is invalid-1Letter-2Num-2L-1N4L');
                    }
                    if (_mpesaCodeController.text.length > 10) {
                      return ('Mpesa code is invalid');
                    }
                    if (value!.isEmpty) {
                      return 'Please enter an M-pesa payment code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  style: TextStyle(fontFamily: "NotoSansMono", fontWeight:
                  FontWeight.w700, fontSize: 14.0, color: Colors.black),
                  textInputAction: TextInputAction.next,keyboardType: TextInputType.datetime,
                  controller: _paymentDateController,
                  decoration: InputDecoration(labelText: 'Payment Date',
                      prefixIcon: Icon(
                        Icons.calendar_today, color: Colors.red,)),
                  validator: (value) {
                    RegExp dateRegExp = RegExp(
                      r'^([1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$',
                    );
                    if (!dateRegExp.hasMatch(_paymentDateController.text)) {
                      return "Invalid date fomart--correct fomart is dd/mm/yyyy";
                    }
                    if (value!.isEmpty) {
                      return 'Please enter a payment date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  style: TextStyle(fontFamily: "NotoSansMono", fontWeight:
                  FontWeight.w700, fontSize: 14.0, color: Colors.black),
                  textInputAction: TextInputAction.done,

                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount',
                      prefixIcon: Icon(Icons.money, color: Colors.red,)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
                isLoading
                    ? SpinKitSpinningLines(size: 80, color: Colors.pinkAccent,)
                    :

                Container(
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.payment, size: 30, color: Colors.orangeAccent,),
                      onPressed: () {
                        _buyBook();
                      },
                      label: Text('Submit Payment Details',
                        style: GoogleFonts.alice(color: Colors.white60,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buyBook() async {
    //final _selectedBook = ModalRoute.of(context)?.settings.arguments as booksmodel;
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        _isPurchasing = true;
        // _selectedBook = booksmodel as booksmodel;
      });
      try {
        DatabaseReference _userRef = FirebaseDatabase.instance.reference()
            .child('Payments');
        final String Phone = _phoneController.text.toString();
        //final String userId = FirebaseAuth.instance.currentUser!.uid;
        DatabaseEvent databaseEvent = await _userRef.orderByChild('phone')
            .equalTo(Phone)
            .once();
        final DataSnapshot dataSnapshot = databaseEvent.snapshot;
        final Map<dynamic, dynamic> value = dataSnapshot.value as Map<
            dynamic,
            dynamic>;

        final String key = value.keys.first;

        final DatabaseEvent Event = await _userRef.child(key).once();
        final DataSnapshot keySnapshot = Event.snapshot;
        final Map<dynamic, dynamic>? values = keySnapshot.value as Map<
            dynamic,
            dynamic>?;
        if (keySnapshot.value != null && values != null &&
            values.containsKey('mpesacode')) {
          String status = values['mpesacode'] as String;
          if (status == _mpesaCodeController.text.toString()) {
            QuickAlert.show(context: context,
                type: QuickAlertType.error,
                title: 'Failed',
                text: 'MpesaCode you Provided Is Expired or InValid');
          } else {
            setState(() {
              isLoading = true;
              _isPurchasing = true;
            });
            final DatabaseReference _paymentRef = FirebaseDatabase.instance
                .reference();
            _paymentRef.child('Payments').push().set({
              'cname': _nameController.text.toString().trim(),
              'phone': _phoneController.text,
              'mpesacode': _mpesaCodeController.text.toString(),
              'paymentDate': _paymentDateController.text.toString(),
              'amount': _amountController.text,
              'bookId': _selectedBook!.title,
              'transactionStatus': 'pending',});

            QuickAlert.show(context: context,
                type: QuickAlertType.success,
                title: "SENT",
                confirmBtnText:
                "OKAY",
                text: "Your Payment Is received For Processing,  Wait For Status Check...",
                barrierDismissible: true,
                onConfirmBtnTap: () {
                  toReadingBook(_selectedBook!.fullContentUrl);
                },
                textColor: Colors.cyanAccent,
                titleColor: Colors.red,
                backgroundColor: Colors.deepOrangeAccent,
                confirmBtnColor: Colors.black87,
                borderRadius: 25);
            setState(() {
              _isPurchasing = false;
            });
          }
        } else {
          QuickAlert.show(context: context,
              type: QuickAlertType.error,
              title: "Mpesa-code ERROR",
              confirmBtnText:
              "OKAY",
              text: "Failed To Process Payment",
              textColor: Colors.cyan,
              titleColor: Colors.red,
              backgroundColor: Colors.deepPurple,
              confirmBtnColor: Colors.black87,
              borderRadius: 25);
        }
      }
      catch (e) {
        setState(() {
          isLoading = false;
          _isPurchasing = false;
        });
        QuickAlert.show(context: context,
            type: QuickAlertType.error,
            title: "DATABASE ERROR",
            confirmBtnText:
            "OKAY",
            text: "Failed To Load Payment data $e",
            textColor: Colors.cyan,
            titleColor: Colors.red,
            backgroundColor: Colors.deepPurple,
            confirmBtnColor: Colors.black87,
            borderRadius: 25);
        //print(e);
      }

    }
    setState(() {
      isLoading = false;
    });

  }

  toReadingBook(String url) async {
    //final _selectedBook = ModalRoute.of(context)?.settings.arguments as booksmodel;
    try {
      DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('Payments');
      final String Phone = _phoneController.text.toString();
      //final String userId = FirebaseAuth.instance.currentUser!.uid;
      DatabaseEvent databaseEvent = await _userRef.orderByChild('phone')
          .equalTo(Phone)
          .once();
      final DataSnapshot dataSnapshot = databaseEvent.snapshot;
      final Map<dynamic, dynamic> value = dataSnapshot.value as Map<dynamic, dynamic>;

      final String key = value.keys.first;

      final DatabaseEvent Event = await _userRef.child(key).once();
      final DataSnapshot transSnapshot = Event.snapshot;
      final Map<dynamic, dynamic>? values = transSnapshot.value as Map<dynamic, dynamic>?;

      if (transSnapshot.value != null && values != null &&
          values.containsKey('transactionStatus')) {
        String status = values['transactionStatus'] as String;
        if (status == 'completed') {
          // Navigate to the book reading page

          DatabaseReference dbRef = FirebaseDatabase.instance.reference();
          await dbRef
              .child("userBooks").push().set({
          'bookId' : _selectedBook!.title,
          'ClientId' : usernum,
          });

          Navigator.of(context).push(
              (MaterialPageRoute(builder: (BuildContext context) => bookReading(book: _selectedBook!))));

          QuickAlert.show(context: context,
              type: QuickAlertType.success,
              title: "Success", text: "Transaction Successfully completed");
        } else {
          setState(() {
            isLoading = false;
            _isPurchasing = false;
          });
          QuickAlert.show(context: context,
              type: QuickAlertType.info,
              title: "Transaction Pending Approval");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Transaction pending. Please try again later.')));
        }
      } else {
        QuickAlert.show(context: context,
            type: QuickAlertType.error,
            title: "Transaction Status Unknown");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Your Payment Status Is Uknown')));
      }

    } catch (e) {
      setState(() {
        isLoading = false;
        _isPurchasing = false;
      });
      print(e);
// Handle errors
      QuickAlert.show(context: context,
          type: QuickAlertType.info,barrierDismissible: false,
          title: "ERROR!",
          cancelBtnText:
          "OKAY",
          text: "Database Error  :$e",
          textColor: Colors.orangeAccent,
          titleColor: Colors.red,
          backgroundColor: Colors.black,
          cancelBtnTextStyle: TextStyle(fontFamily: "NotoSansMono",
            fontWeight: FontWeight.w800,
            fontSize: 20.0,),
          borderRadius: 25);

    }
  }
}

