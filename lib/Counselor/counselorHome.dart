import 'package:flutter/material.dart';
class counselorhome extends StatefulWidget {
  const counselorhome({Key? key}) : super(key: key);

  @override
  State<counselorhome> createState() => _counselorhomeState();
}

class _counselorhomeState extends State<counselorhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WELCOME COUNSELOR!'),
      ),
    );
  }
}
