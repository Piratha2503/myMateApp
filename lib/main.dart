import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Homepages/AddTokenPage.dart';
import 'Homepages/CheckMatch.dart';
import 'Homepages/SubscribedHomeScreen.dart';
import 'MatchPages/KanaPorutham.dart';
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
      home: CheckmatchPage(),
    );
  }
}
