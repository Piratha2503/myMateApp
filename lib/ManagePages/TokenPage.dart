import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:responsive_screen_type/responsive_screen_type.dart';

class Tokenpage extends StatefulWidget {
  const Tokenpage({Key? key}) : super(key: key);

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
