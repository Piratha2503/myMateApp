import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/GenerateChart.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscibe.dart';
import 'package:mymateapp/Homepages/RegisterPages/OTPPage.dart';
import 'package:mymateapp/Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'package:mymateapp/Homepages/WelcomeScreen.dart';
import 'package:mymateapp/Matching/Rasi.dart';
import 'package:mymateapp/dbConnection/Clients.dart';
import 'package:pinput/pinput.dart';

import 'ChartPages/ManualRasiChartPage.dart';
import 'Homepages/RegisterPages/Pinput.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    TestClient clientProfile = TestClient();
    clientProfile.name = "Piratha";
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: Colors.blue[200]),
      debugShowCheckedModeBanner: false,
      home: OtpPinput(docId: "9l2knrHe8XLZL2S3erxy"),
    );
  }
}
