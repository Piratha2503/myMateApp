import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mymateapp/Homepages/ListViewPage.dart';
import 'package:mymateapp/Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'package:mymateapp/ManagePages/SettingsPage.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: Colors.blue[200]),
      debugShowCheckedModeBanner: false,
      home: Settingspage(),
    );
  }
}
