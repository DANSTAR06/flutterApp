import 'package:flutter/material.dart';
class smHome extends StatefulWidget {
  const smHome({Key? key}) : super(key: key);

  @override
  State<smHome> createState() => _smHomeState();
}

class _smHomeState extends State<smHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WELCOME SERVICE MANAGER!'),
      ),
    );
  }
}
