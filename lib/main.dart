import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/CompleteProfileScreen/CompleteProfileMain.dart';
import 'package:mymateapp/Homepages/Profiles/EditPage.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/Homepages/myMatePage/myMatePageMain.dart';
import 'package:mymateapp/MyMateCommonBodies/MyMateApis.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChartPages/GenerateChart.dart';
import 'Homepages/CompleteProfileScreen/CompleteThree.dart';
import 'Homepages/MessagePage.dart';
import 'Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'Homepages/Profiles/MoreAboutMe.dart';
import 'Homepages/Profiles/boost_profile.dart';
import 'Homepages/SubscribedHomeScreen.dart';
import 'Homepages/SubscribedhomeScreen/SubscribedHomeScreenBeforeProfileCompleted.dart';
import 'Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'Homepages/explorePage/explorePageMain.dart';
import 'Homepages/AddTokenPage.dart';
import 'Homepages/notification_page.dart';
import 'Homepages/notification_service.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  await NotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? docId =prefs.getString('docId');
  print('docid is :$docId');

  // if (docId != null ){
  //   NotificationService.startRealTimeListener(docId);
  //  } else {
  //   print ("No saved docId found,skipping firestore listener");
  //
  //  }
  // print(docId);

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
           // ProfilePage(selectedBottomBarIconIndex: 3, docId: 'zx7sjs4q0Kq43FPwrybU')
          //AuthcheckState()
          //ProfilePage(docId: "uL82irbLGveGxNP6Gyfd", selectedBottomBarIconIndex:0,),
        // CheckmatchPage( clientDocId: '', soulDocId: '',),
       // RegisterPage()
      // SubscribedhomescreenStructuredPage(docId: 'E0JFHhK2x6Gq2Ac6XSyP',)
     // CompleteProfilePage(docId: '3qmCKRqXr06udbChynui')
      // EditPage(docId: 'qizCb7sXUhWEPy0awx0e', onSave: () {  },)
       // GenerateChart()
        //AstroChartScreen()
         // boostprofile(docId: 'SYfMHh6YUL6yobmIZXwO',)
          //PageThree(docId: 'qHPJAB0C6DavcfYnHAoO', onSave: () {  },)
           //   MyMatePage(results: [], search: [], docId: 'qHPJAB0C6DavcfYnHAoO',)
            // NotificationPage(0, docId: 'zx7sjs4q0Kq43FPwrybU',)
             //  MyMatePage(results: [], search: [], docId: "SYfMHh6YUL6yobmIZXwO",)
               MessagePage(docId: 'SYfMHh6YUL6yobmIZXwO', soulId: 'E0JFHhK2x6Gq2Ac6XSyP',)
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