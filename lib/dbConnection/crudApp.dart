import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/MyProfile.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Firebase.dart';
import 'package:mymateapp/dbConnection/viewPage.dart';

class crudApp extends StatefulWidget{
  const crudApp({super.key});

  @override
  State<crudApp> createState() => _crudAppState();
}

class _crudAppState extends State<crudApp>{

  final Firebase firebase = Firebase();

  @override
   Widget build(BuildContext context) {

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

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              final clientName = client['full_name'];
              final docId = client.id;

              return ListTile(

                title: Text(clientName,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600
                ),),
                trailing: IconButton(onPressed: (){
                  firebase.deleteClient(docId);
                }, icon: const Icon(Icons.settings)),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder:
                  (context)=>ProfilePage(docId: docId,)));
                  //firebase.updateClient(docId,"Jathu");
                },

              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        firebase.addClient();
      }, child: Icon(Icons.add,size: 30,weight: 600,),
      backgroundColor: MyMateThemes.textColor,
      foregroundColor: Colors.white,),
    );
  }
}