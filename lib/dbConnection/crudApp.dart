import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/dbConnection/Firebase.dart';

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
        backgroundColor: CupertinoColors.systemBlue,
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
              final clientName = client['Name'];
              final docId = client.id;

              return ListTile(
                title: Text(clientName,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600
                ),),
                trailing: IconButton(onPressed: (){
                  firebase.deleteClient(docId);
                }, icon: const Icon(Icons.settings)),
                onTap: (){
                  firebase.updateClient(docId,"Jathu");
                },

              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        firebase.addClient();
      }),
    );
  }
}