import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

class FirebaseDB{

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("client");

  Future<void> addClient(ClientData client) async{

    collectionReference.add(client.toMap());
  }

  Future<DocumentSnapshot> getClientByMobile(String mobile) async{

    QuerySnapshot snapshot = await collectionReference.where("contactInfo.mobile",isEqualTo: mobile).get();

    DocumentSnapshot documentSnapshot = snapshot.docs.first;

    return documentSnapshot;

  }

  Future<DocumentSnapshot> getClientByDocId(String? docId){
    return collectionReference.doc(docId).snapshots().first;
  }

  Future<void> updateClient(ClientData clientData) async{
    await collectionReference.doc(clientData.docId).update(clientData.toMap());
  }
}