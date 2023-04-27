import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:ultimate_excellence_limited/model/booksmodel.dart';
import 'dart:convert' show Encoding, base64, base64Encode;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import '../pages/home.dart';



class bookReading extends StatefulWidget {
 booksmodel book;
 bookReading({ required this.book});
  @override
  State<bookReading> createState() => _bookReadingState();
}

class _bookReadingState extends State<bookReading> {
  //booksmodel? _selectedBook;

  PDFDocument? document;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchBookContent();

    // Get a reference to the PDF path node in the database
    DatabaseReference pdfPathRef = FirebaseDatabase.instance.reference().child('userBook').child("bookId");

// Attach a listener to the reference
   /* pdfPathRef.addValueEventListener(new ValueEventListener() {
    @Override
    public void onDataChange(DataSnapshot dataSnapshot) {
    // Get the PDF path from the snapshot
    String pdfPath = dataSnapshot.getValue(String.class);

    // Do something with the PDF path (e.g., load the PDF)
    loadPdf(pdfPath);
    }

    @Override
    public void onCancelled(DatabaseError databaseError) {
    // Handle the error
    Log.w(TAG, "Failed to read PDF path.", databaseError.toException());
    }
    });*/


    String pdfAssetPath = 'assets/dmwdocfull.pdf';
    ByteData data =  rootBundle.load(pdfAssetPath) as ByteData;
    List<int> bytes = data.buffer.asUint8List();
    String base64Data = base64Encode(bytes);
    Uri pdfUri = Uri.dataFromBytes(bytes, mimeType: 'application/pdf');
  }

  Future<List<int>> fetchDocumentBytes(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch document bytes');
    }
  }


  void fetchBookContent() async {
    try {
      // Load the PDF document from the URL
      final response = await http.get(Uri.parse(widget.book.fullContentUrl));
      final bytes = response.bodyBytes;

      // Save the byte array to a local file
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp.pdf');
      await tempFile.writeAsBytes(bytes);
      if (response.statusCode == 200) {
        // Create a PDFDocument object from the local file
        setState(() async {
          document = await PDFDocument.fromFile(tempFile);
          isLoading = false;
        });
      } else {
        print("Failed to load book content: ${response.statusCode}");
      }
    } catch (e) {
      print("Error loading book content: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(child: Icon(Icons.arrow_back,size: 30,color: Colors.purpleAccent,),
        onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));},),
        title: Text('Reading Page'),
      ),
      body: Center(
        child: document == null
            ? CircularProgressIndicator(color: Colors.purpleAccent,strokeWidth: 5,)
            : PDFViewer(
          document: document!,
          showPicker: true,
          enableSwipeNavigation: true,
          scrollDirection:Axis.horizontal,
          indicatorBackground: Colors.pink,

        ),
      ),
    );
    }
  }

