import 'package:flutter/material.dart';

import '../model/booksmodel.dart';
class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<booksmodel>  _books = [
    booksmodel(

      title: 'Recipe for Wholesome Student',
      author: 'Samuel Kanja',
      imageUrl: 'assets/recipebook.jpg',
      previewUrl: 'assets/recipeback.png',
      fullContentUrl: 'https://www.mediafire.com/file/ghw62w5j9pupfxl/The_Gifts_of_Imperfection__Embrace_Who_You_Are_%2528_PDFDrive_%2529.pdf/file',
      price: 250,
    ),
    booksmodel(

      title: 'Career Decoder',
      author: 'SamuelKanja',
      imageUrl: 'assets/careerDb.jpg',
      previewUrl: 'assets/careerback.png',
      fullContentUrl: 'https://www.mediafire.com/file/ghw62w5j9pupfxl/The_Gifts_of_Imperfection__Embrace_Who_You_Are_%2528_PDFDrive_%2529.pdf/file',
      price: 500,
    ),
    booksmodel(

      title: 'Fashioned For Life',
      author: 'Samuel Kanja',
      imageUrl: 'assets/fashioned.jpg',
      previewUrl: 'assets/fashionedback.jpg',
      fullContentUrl: 'https://www.mediafire.com/file/ghw62w5j9pupfxl/The_Gifts_of_Imperfection__Embrace_Who_You_Are_%2528_PDFDrive_%2529.pdf/file',
      price: 400,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/book_preview',
                arguments: _books[index],
              );
            },
            child: ListTile(
              title: Text(_books[index].title),
              subtitle: Text(_books[index].author),
              trailing: Text('\$${_books[index].price}'),
            ),
          );
        },
      ),
    );
  }
}
