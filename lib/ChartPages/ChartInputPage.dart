import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartInputPageWidgets.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ChartInputPage extends StatefulWidget {
  const ChartInputPage({super.key});

  @override
  State<ChartInputPage> createState() => _ChartInputPageState();
}

class _ChartInputPageState extends State<ChartInputPage> {
  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(),
      body: Column(
        children: [
          ContainerColumn(),
          SizedBox( height: 2,),
          PlaceSearch(),
          SizedBox( height: 2, ),
          DOB(),
          TOB(),
          Rasi(),
          Nadchathira(),
        ],
      ),
    );
  }
}

