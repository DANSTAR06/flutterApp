import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/booksmodel.dart';
import '../ourBooks/bookReading.dart';
import '../ourBooks/ourbooks.dart';
class BookPurchasePage extends StatefulWidget {
  const BookPurchasePage({Key? key}) : super(key: key);

  @override
  _BookPurchasePageState createState() => _BookPurchasePageState();
}

class _BookPurchasePageState extends State<BookPurchasePage> {

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mpesaCodeController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _mpesaCodeController.dispose();
    _paymentDateController.dispose();
    _amountController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  late booksmodel? _selectedBook;
  late String _useremail;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _useremail = user.email!;
    }
  }

  Future<bool> hasUserPurchasedBook(String bookId) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    DataSnapshot snapshot =
    (await dbRef.child("userBooks").child(_useremail).child(bookId).once()) as DataSnapshot;
    return snapshot.value != null;
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Save form data to the database
      DatabaseReference dbRef = FirebaseDatabase.instance.reference();
      String bookId = _selectedBook!.fullContentUrl;
      String paymentCode = _mpesaCodeController.text;
      String name = _nameController.text;
      String phone = _phoneController.text;
      String email = _emailController.text;
      String amount = _amountController.text;
      String paymentDate = _paymentDateController.text;
      await dbRef.child('Payments').child(bookId).set({
        "mpesacode": paymentCode,
        "clientName": name,
        "phone": phone,
        "clientEmail": email,
        "amount": amount,
        "paymentDate": paymentDate,
        "transationStatus" : 'pending',
      });

      // Check the payment status
      DatabaseReference paymentRef =
      dbRef.child('Payments').child(bookId).child("transationStatus");
      String? status;
      int retries = 0;
      while (status != "approved" && retries < 10) {
        await Future.delayed(Duration(seconds: 2));
        DataSnapshot paymentSnapshot = (await paymentRef.once()) as DataSnapshot;
        status = paymentSnapshot.value as String?;
        retries++;
      }

      if (status == "completed") {
        booksmodel book = booksmodel as booksmodel;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                bookReading(book: book)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Payment not approved. Please try again later."),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print("Error submitting form: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error submitting form. Please try again later."),
        backgroundColor: Colors.red,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Buy Book"),
    ),
    body: isLoading
    ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
    child: Form(
    key: _formKey,
    child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(
          labelText: "Name",
        ),
        controller: _nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your name";
          }
          return null;
        },
      ),
      SizedBox(height: 20),
      TextFormField(
        controller: _phoneController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your phone number";
          } else if (!isNumeric(value)) {
            return "Please enter a valid phone number";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Phone Number",
        ),
      ),
      SizedBox(height: 20),
      TextFormField(
        controller: _mpesaCodeController,
        validator: (value) {
          if (value!.isEmpty) {
    return "Please enter your MPESA code";

          }if (!isNumeric(value)) {
            return "Please enter a valid MPESA code";
          }
              if(value.length > 10) {
             return "Enter valid Code";
        }
          return null;
        },
        decoration: InputDecoration(
          labelText: "MPESA Code",
        ),
      ),
      SizedBox(height: 20),
      TextFormField(
        controller: _paymentDateController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter payment date";
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: "Payment Date",
        ),
      ),
      SizedBox(height: 20),
      TextFormField(
        controller: _amountController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter payment amount";
          } else if (!isNumeric(value)) {
            return "Please enter a valid payment amount";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Payment Amount",
        ),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            final paymentCode = _mpesaCodeController.text;
            final paymentAmount = _amountController.text;
            final paymentDate = _paymentDateController.text;
            final buyerName = _nameController.text;
            final buyerPhone = _phoneController.text;
            final bookId = _selectedBook!.fullContentUrl;

            final DatabaseReference _paymentRef = FirebaseDatabase.instance
                .reference();
          await  _paymentRef.child('payments').push().set({
              'bookId': bookId,
              'paymentAmount': paymentAmount,
              'paymentDate': paymentDate,
              'clientName': buyerName,
              'clientPhone': buyerPhone,
              'transactionStatus': 'pending',
            }).then((value) {
              setState(() {
                isLoading = false;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentStatusPage(
                    paymentCode: paymentCode,
                    selectedBook: _selectedBook!,
                  ),
                ),
              );
            }).catchError((error) {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(
                msg: "Error occurred while processing payment",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            });
          }
        },
        child: Text("Buy Now"),
      ),
    ],
    ),
    ),
    ),
    );
  }
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
class PaymentStatusPage extends StatefulWidget {
  final String paymentCode;
  final booksmodel selectedBook;

  const PaymentStatusPage({
    required this.paymentCode,
    required this.selectedBook,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentStatusPageState createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  late Stream<DataSnapshot> _paymentStream;

  @override
  void initState() {
    super.initState();
    _paymentStream = FirebaseDatabase.instance.reference().child('Payments').child(widget.paymentCode) as Stream<DataSnapshot>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Status'),
      ),
      body: StreamBuilder<DataSnapshot>(
        stream: _paymentStream,
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.value == null) {
            return Center(
              child: Text('No payment found.'),
            );
          }
          final paymentData = snapshot.data!.value!;
          Map<dynamic, dynamic> value = paymentData as Map<dynamic, dynamic>;

          final String status = paymentData['transactionStatus'];
          if (status == 'completed') {
            booksmodel book = booksmodel as booksmodel;
            return bookReading(
              book: book,
            );
          } else if (status == 'pending') {
            return Center(
              child: Text('Payment is pending approval.'),
            );
          } else {
            return Center(
              child: Text('Payment was not approved.'),
            );
          }
        },

      ),

    );
  }

}