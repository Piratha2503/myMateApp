import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:responsive_screen_type/responsive_screen_type.dart';

class Summarypage extends StatefulWidget {
  const Summarypage({Key? key}) : super(key: key);

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
