import 'package:flutter/material.dart';


class Helppage extends StatefulWidget {
  const Helppage({super.key});

  @override
  State<Helppage> createState() => _HelppageState();
}

class _HelppageState extends State<Helppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Page"),
        centerTitle: true,
      ),
    );
  }
}
