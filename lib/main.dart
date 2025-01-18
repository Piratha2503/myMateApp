import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepages/Profiles/boost_profile.dart';
import 'Homepages/explorePage/explorePageMain.dart';
import 'Homepages/AddTokenPage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

      home:
      // ProfilePage(docId: "E0JFHhK2x6Gq2Ac6XSyP", selectedBottomBarIconIndex:0,),
      // CheckmatchPage( clientDocId: '', soulDocId: '',),
     RegisterPage()
    );
  }
}


class AuthcheckState extends StatefulWidget {
  @override
  State<AuthcheckState> createState() => _AuthcheckState();
}

class _AuthcheckState extends State<AuthcheckState> {
  Future<String?> getSavedDocId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('docId');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getSavedDocId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final docId = snapshot.data;
          if (docId != null) {
            return ProfilePage(docId: docId, selectedBottomBarIconIndex: 3,);
          } else {
            return const RegisterPage();
          }
        }
      },
    );
  }
}