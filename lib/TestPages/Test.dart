import 'package:flutter/material.dart';
import 'package:mymateapp/TestPages/Test2.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Future<void> saveClient() async{

    FirebaseDB firebaseDB = FirebaseDB();
    await firebaseDB.addClient(GenerateClient.generateClient());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Client saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ElevatedButton(onPressed: saveClient, child: Text("Click"),

        ),
      ),
    );
  }
}