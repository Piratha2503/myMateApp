import 'package:flutter/material.dart';

class Summarypage extends StatefulWidget {
  const Summarypage({super.key});

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary Page"),
        centerTitle: true,
      ),
    );
  }
}
