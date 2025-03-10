import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscribe.dart';
import 'package:mymateapp/Homepages/PaymentDetailsPage.dart';
import 'package:mymateapp/Homepages/Profiles/EditPage.dart';
import 'package:mymateapp/Homepages/RegisterPages/ChartOptions.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/Homepages/explorePage/exploreProvider.dart';
import 'package:mymateapp/ManagePages/ManagePage.dart';
import 'package:mymateapp/ManagePages/SettingsPage.dart';
import 'package:mymateapp/ManagePages/SummaryPage.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChartPages/ChartCalPage.dart';
import 'ChartPages/ChartInputPage.dart';
import 'ChartPages/ChartViewPage.dart';
import 'ChartPages/GenerateChart.dart';
import 'ChartPages/PlaceDateTimeInput.dart';
import 'Homepages/AddTokenPages/AddTokenMain.dart';
import 'Homepages/CompleteProfileScreen/CompleteProfileMain.dart';
import 'Homepages/FilterPage.dart';
import 'Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'Homepages/Profiles/OthersProfile.dart';
import 'Homepages/RegisterPages/NameAndGenderPage.dart';
import 'Homepages/RegisterPages/OTPPage.dart';
import 'Homepages/RegisterPages/Pinput.dart';
import 'Homepages/SubscribedhomeScreen/SubscribedHomeScreenBeforeProfileCompleted.dart';
import 'Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'Homepages/WelcomeScreen.dart';
import 'Homepages/explorePage/explorePageMain.dart';
import 'ManagePages/AllActionPage.dart';
import 'ManagePages/HelpPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExploreProvider()),
      ],
      child: MyApp(),
    ),
  );
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
           //OtherProfilePage(SoulId: 'E0JFHhK2x6Gq2Ac6XSyP',),
          // ProfilePage(selectedBottomBarIconIndex: 0, docId: 'E0JFHhK2x6Gq2Ac6XSyP')
            AddTokenMainPage(docId: '',),
           //FilterPage(),
           //MyMatePage(results: [], search: [], docId: '',)
             // EditPage(docId: 'E0JFHhK2x6Gq2Ac6XSyP', onSave: () {  }),
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