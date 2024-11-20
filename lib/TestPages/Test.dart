import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

class Test extends StatefulWidget{
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();

}

class _TestState extends State<Test>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedListView(
        duration: 100,
        extendedSpaceBetween: 30,
        spaceBetween:10, children: [],
       );
  }

}