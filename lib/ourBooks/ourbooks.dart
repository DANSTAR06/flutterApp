import 'dart:typed_data';
import 'dart:convert' show Encoding, base64, base64Encode;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultimate_excellence_limited/ourBooks/bookReading.dart';
import '../model/booksmodel.dart';
import '../pages/home.dart';
import 'buyingbooks.dart';
import 'package:path_provider/path_provider.dart';






class BookReadingPage extends StatefulWidget {

  @override
  _BookReadingPageState createState() => _BookReadingPageState();

}

class _BookReadingPageState extends State<BookReadingPage> {


  late List<booksmodel> _books;
 late String _userId;
  late booksmodel?  _selectedBook =null;
  bool _isPreviewing = false;
  bool _isPurchasing = false;



  @override
  Future<void> initState() async {
    super.initState();

    _books = [
      booksmodel(

        title: 'Recipe for Wholesome Student',
        author: 'Samuel Kanja',
        imageUrl: 'assets/recipebook.jpg',
        previewUrl: 'assets/recipeback.png',
        fullContentUrl: 'assets/dmwdocfull.pdf',
        price: 250,
      ),
      booksmodel(

        title: 'Career Decoder',
        author: 'SamuelKanja',
        imageUrl: 'assets/careerDb.jpg',
        previewUrl: 'assets/careerback.png',
        fullContentUrl: 'assets/dmwdocfull.pdf',
        price: 500,
      ),
      booksmodel(

        title: 'Fashioned For Life',
        author: 'Samuel Kanja',
        imageUrl: 'assets/fashioned.jpg',
        previewUrl: 'assets/fashionedback.jpg',
        fullContentUrl: 'ulpreview.pdf',
        price: 400,
      ),
    ];
    for (int i = 0; i < _books.length; i++) {
      String pdfAssetPath = _books[i].fullContentUrl;
      String sanitizedPath = pdfAssetPath.replaceAll(RegExp(r'[.#$\[\]]'), '');
      String storagePath = 'userBooks/$sanitizedPath';

      ByteData data = await rootBundle.load(pdfAssetPath);
      List<int> bytes = data.buffer.asUint8List();
      String base64Data = base64Encode(bytes);
      Uri pdfUri = Uri.dataFromBytes(bytes, mimeType: 'application/pdf');

      DatabaseReference pdfRef = FirebaseDatabase.instance.reference().child(storagePath);
      await pdfRef.set({'bookId': pdfUri.toString()});
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
        appBar: AppBar(elevation: 0,backgroundColor: Colors.cyan,leading: GestureDetector(child: Icon(Icons.arrow_back,),onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));}),
          title: Text('OUR BOOKS'),
        ),
        bottomNavigationBar: Container(
          color: Colors.black38,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15),
            child: GNav(gap: 8,backgroundColor: Colors.grey,tabBorderRadius: 100,
              color: Colors.cyanAccent,activeColor: Colors.deepOrange,tabBackgroundColor: Colors.white,
              tabs: [
              GButton(icon: CupertinoIcons.home,text: 'Home',textSize: 18,textStyle: GoogleFonts.aboreto(),onPressed:
                  (){Navigator.push(context, MaterialPageRoute(builder: (context)=>BookReadingPage()));},),
             // GButton(icon: CupertinoIcons.square_favorites,text: 'Favorites',textSize: 18,textStyle: GoogleFonts.aboreto()),
              GButton(icon: Icons.library_add_check,text: 'Purchased',textSize: 18,textStyle: GoogleFonts.aboreto(),onPressed: (){
                //todo list of favourite books
              },),
            ],

            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(style: GoogleFonts.alata(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w900),
                  textInputAction: TextInputAction.search,

                  decoration: InputDecoration(
                      prefixIcon:Icon(CupertinoIcons.search,color: Colors.deepOrange,size: 30,),hintText: "Search for a Book"
                  ),),
          SizedBox(height: 10,),
          Expanded(
          child: _selectedBook != null
          ? _isPreviewing
              ? Image.asset(_selectedBook!.previewUrl)
              : Image.asset(_selectedBook!.imageUrl)
          : ListView.builder(
    itemCount: _books.length,
    itemBuilder: (context, int index)
    {
    final book = _books[index];
    return ListTile(onLongPress: (){},
    leading:
    Image.asset(book.imageUrl),
      title: Text(book.title,style: GoogleFonts.actor(fontWeight: FontWeight.w900,fontSize: 18)),
      subtitle: Text(book.author,style: GoogleFonts.arsenal(fontWeight: FontWeight.w500,fontSize: 14),),
      trailing: Text('${book.price.toStringAsFixed(2)}'+' ksh.',style: GoogleFonts.abel(fontWeight: FontWeight.w400,fontSize: 16)),
      onTap: () {
          setState(() {
            _selectedBook = book;
            _isPreviewing = true;
          });
      },
    );
    },
          ),
          ),
                if (_selectedBook != null)
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _selectedBook!.title,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          _selectedBook!.author,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _isPreviewing
                            ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isPreviewing = false;
                            });
                          },
                          child: Text('See Cover Page'),
                        )
                            : _isPurchasing
                            ? CircularProgressIndicator(backgroundColor: Colors.redAccent,)
                            : ElevatedButton(
                          onPressed: (){

                            booksmodel book = _books[0];
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookPurchaseForm(book: book),
                              ),
                            );
                          },
                          child: Text('Buy Full Book'),
                        ),
                      ],
                    ),
                  ),
              ],
          ),
        ),
    );
  }
}