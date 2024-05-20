import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:responsive_screen_type/responsive_screen_type.dart';

class Aboutpage extends StatefulWidget {
  const Aboutpage({Key? key}) : super(key: key);

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Page"),
        centerTitle: true,
      ),
    );
  }
}
