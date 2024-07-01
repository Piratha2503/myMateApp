import 'package:flutter/material.dart';

class Tokenpage extends StatefulWidget {
  const Tokenpage({super.key});

  @override
  State<Tokenpage> createState() => _TokenpageState();
}

class _TokenpageState extends State<Tokenpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Token Page"),
        centerTitle: true,
      ),
    );
  }
}
