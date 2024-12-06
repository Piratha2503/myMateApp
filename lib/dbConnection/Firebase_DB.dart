import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

class FirebaseDB{

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("client");

  Future<void> addClient(ClientData client) async{

    collectionReference.add(client.toMap());
  }

}