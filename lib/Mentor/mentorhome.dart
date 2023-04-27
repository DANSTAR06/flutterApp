import 'package:flutter/material.dart';
class mentorhome extends StatefulWidget {
  const mentorhome({Key? key}) : super(key: key);

  @override
  State<mentorhome> createState() => _mentorhomeState();
}

class _mentorhomeState extends State<mentorhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WELCOME MENTOR!'),
      ),
    );
  }
}
