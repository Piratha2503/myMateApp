import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscibe.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'package:mymateapp/Homepages/Profiles/EditPage.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

import 'ChartPages/ManualNavamsaChartPage.dart';
import 'ChartPages/ManualRasiChartPage.dart';
import 'Homepages/Profiles/OthersProfile.dart';
import 'Homepages/RegisterPages/ChartOptions.dart';
import 'Homepages/RegisterPages/NameAndGenderPage.dart';
import 'Homepages/explorePage/explorePageMain.dart';
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
    Astrology astrology = Astrology();

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

      home:
      // OtherProfilePage(docId: 'J6SNjRd4P3WvV78EFddP',),
      RegisterPage(),
      // ManualNavamsaChartPage(clientData: clientData, astrology: astrology, ),
      // ExplorePage(
      //   initialTabIndex: 0,
      //   results: [], search: [], docId: '', // Pass an empty list initially
      // ),
    );
  }
}
