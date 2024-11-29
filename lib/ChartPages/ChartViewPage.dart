import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartViewPageWidgets.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ChartViewPage extends StatefulWidget {
  const ChartViewPage({super.key});

  @override
  State<ChartViewPage> createState() => _ChartViewPageState();
}

class _ChartViewPageState extends State<ChartViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar( title: TitleContainer(),
        backgroundColor: MyMateThemes.backgroundColor, ),
      body: Column(
        children: [
          SizedBox( height: 25,),
          ChartImage(),
          SizedBox( height: 50,),
          EditAndNextButton(),
        ],
      ),
    );
  }
}
