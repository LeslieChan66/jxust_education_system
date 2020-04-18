import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String documentData;
  HomePage(this.documentData);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Text(widget.documentData),
        ),
      ),
    );
  }
}
