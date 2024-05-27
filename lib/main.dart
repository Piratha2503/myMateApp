import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartInputPage.dart';
import 'package:mymateapp/ChartPages/ChartViewPage.dart';
import 'package:mymateapp/Homepages/ChartOptions.dart';
import 'package:mymateapp/Homepages/GenerateChart.dart';
import 'package:mymateapp/Homepages/MyProfile.dart';
import 'package:mymateapp/Homepages/NameAndGenderPage.dart';
import 'package:mymateapp/Homepages/RegisterPage.dart';
import 'package:mymateapp/Homepages/StartPage.dart';
import 'package:mymateapp/Homepages/Test2.dart';
import 'package:mymateapp/Homepages/Test3.dart';
import 'package:mymateapp/Homepages/WelcomeScreen.dart';
import 'package:mymateapp/Homepages/Test.dart';
import 'package:mymateapp/Homepages/OTPPage.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mymateapp/ManagePages/ManagePage.dart';
import 'package:mymateapp/ChartPages/ManualRasiChartPage.dart';
import 'package:mymateapp/ChartPages/ManualNavamsaChartPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: Colors.blue[200]),
      debugShowCheckedModeBanner: false,
      home: ManualNavamsaChartPage(),
    );
  }
}

/*
AIzaSyAA71gXSi3WeW2NaC4aIzMMlmuVCP0rrV8
*/
