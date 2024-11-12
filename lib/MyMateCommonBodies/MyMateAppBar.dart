import 'package:flutter/material.dart';

class MyMateAppBar extends StatefulWidget{
  const MyMateAppBar({super.key});

  @override
  State<MyMateAppBar> createState() => _MyMateAppBarState();
}

class _MyMateAppBarState extends State<MyMateAppBar>{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("MyMate"),
      ),
    );
  }
}