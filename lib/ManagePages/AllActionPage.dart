import 'package:flutter/material.dart';

class Allactionpage extends StatefulWidget {
  const Allactionpage({super.key});

  @override
  State<Allactionpage> createState() => _AllactionpageState();
}

class _AllactionpageState extends State<Allactionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Action Page"),
        centerTitle: true,
      ),
    );
  }
}
