import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartInputPage.dart';
import 'package:mymateapp/Homepages/Profiles/MyProfile.dart';
import 'package:mymateapp/Homepages/Profiles/OthersProfile.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

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

    ClientData clientData = ClientData();
    PersonalDetails personalDetails = PersonalDetails();
    personalDetails.first_name = "Hello";
    personalDetails.last_name = "Piratha";
    personalDetails.gender = "Male";
    clientData.docId = "TBT3I8DYa3BepMZPPqv6";
    clientData.personalDetails = personalDetails;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: Colors.blue[200]),
      debugShowCheckedModeBanner: false,

      home: ChartInputPage(),
    );
  }
}