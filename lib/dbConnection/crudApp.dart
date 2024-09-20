import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Firebase.dart';

class crudApp extends StatefulWidget {
  const crudApp({super.key});

  @override
  State<crudApp> createState() => _crudAppState();
}

class _crudAppState extends State<crudApp> {
  final Firebase firebase = Firebase();

  Widget ClientCard(String msg, String imgAddress) {
    return Card(
      shadowColor: Colors.white,
      color: Colors.white60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage(imgAddress),
            height: 75,
            width: 200,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            msg,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget MyGridContainer(String msg, String imgAddress) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 500,
        width: 250, // Increase the height of the container
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: CupertinoContextMenu.kEndBoxShadow,
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/a.jpeg"), height: 75),
            SizedBox(height: 10),
            Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> MyClients = firebase.clientList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyMateThemes.primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebase.getClients(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final clients = snapshot.data!.docs;
          List<Widget> clientContainers = clients.map((client) {
            const imgAddress = "assets/images/a.jpeg";
            final clientName = client['full_name'];
            return MyGridContainer(clientName, imgAddress);
          }).toList();
          return GridView.count(
            scrollDirection: Axis.vertical,
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: clientContainers,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firebase.addClient();
        },
        backgroundColor: MyMateThemes.textColor,
        foregroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 30,
          weight: 600,
        ),
      ),
    );
  }
}
