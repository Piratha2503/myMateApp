import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Firebase{


  final CollectionReference clients = FirebaseFirestore.instance.collection('clients');

  //GET
  Stream<QuerySnapshot> getClients() {
    return clients.snapshots();
  }

  //POST
  Future<void> addClient(){
    return clients.add({
      'Name': "Sayushika",
      'Age': 25,
    });
  }

  //UPDATE
  Future<void> updateClient(String docId, String newName){
    return clients.doc(docId).update({
      'Name':newName,
      'Age':30,
    });
  }

  //DELETE
  Future<void> deleteClient(String docId){
    return clients.doc(docId).delete();
  }

}