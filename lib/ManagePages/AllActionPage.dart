import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:responsive_screen_type/responsive_screen_type.dart';

class Allactionpage extends StatefulWidget {
  const Allactionpage({Key? key}) : super(key: key);

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
