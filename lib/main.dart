import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/CompleteProfileScreen/CompleteProfileMain.dart';
import 'package:mymateapp/Homepages/Profiles/EditPage.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'Homepages/Profiles/MoreAboutMe.dart';
import 'Homepages/Profiles/boost_profile.dart';
import 'Homepages/SubscribedHomeScreen.dart';
import 'Homepages/SubscribedhomeScreen/SubscribedHomeScreenBeforeProfileCompleted.dart';
import 'Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'Homepages/explorePage/explorePageMain.dart';
import 'Homepages/AddTokenPage.dart';
import 'Homepages/myMatePage/myMatePageMain.dart';

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

    return ScreenUtilInit(
        designSize: Size(390, 844), // Base size of your UI design
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                primaryColor: Colors.blue[200]),
            debugShowCheckedModeBanner: false,

            home:
            // ProfilePage(selectedBottomBarIconIndex: 3, docId: 'SYfMHh6YUL6yobmIZXwO',)
            //AuthcheckState()
            //ProfilePage(docId: "SYfMHh6YUL6yobmIZXwO", selectedBottomBarIconIndex:0,),
            // CheckmatchPage( clientDocId: '', soulDocId: '',),
           // ExplorePage(docId: '', results: [], search: [],),
           // RegisterPage(),
            //MyMatePage(results: [], search: [], docId: '',)
            SubscribedhomescreenStructuredPage(docId: '',),

          );
        }
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
            return SubscribedhomescreenStructuredPage(docId: docId,);
          } else {
            return RegisterPage();
          }
        }
      },
    );
  }
}