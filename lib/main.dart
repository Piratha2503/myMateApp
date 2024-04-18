import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/ChartOptions.dart';
import 'package:mymateapp/Homepages/GenerateChart.dart';
import 'package:mymateapp/Homepages/NameAndGenderPage.dart';
import 'package:mymateapp/Homepages/RegisterPage.dart';
import 'package:mymateapp/Homepages/StartPage.dart';
import 'package:mymateapp/Homepages/WelcomeScreen.dart';
import 'package:mymateapp/Homepages/Test.dart';
import 'package:mymateapp/Homepages/OTPPage.dart';
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
        primaryColor: Colors.blue[200]
      ),
      debugShowCheckedModeBanner: false,
      home: const GenerateChart(),
    );
  }
}

