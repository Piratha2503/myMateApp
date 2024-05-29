import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Firebase{

  final CollectionReference clients =
  FirebaseFirestore.instance.collection('clients');

  //GET
  Stream<QuerySnapshot> getClients() {
    return clients.snapshots();
  }

  //POST
  Future<void> addClient(){

    return clients.add({
      'full_name': "Thaneswaran Suginshan",
      'age': 28,
      'dob': '25-03-1992',
      'mobile': 0778741623,
      'mobile_countryCode': 'lk',
      'gender': 'male',
      'civil_status': 'single',
      'employment_type': 'professional',
      'occupation':'Engineer',
      'height':154,
      'district':'Colombo',
      'education': 'B.S.C',
      'religion': 'hindu',
      'caste': 'nil',
      'language': 'Tamil',
      'no_of_siblings': 2,
      'country': 'Srilanka',
    });

  }

  //UPDATE
  Future<void> updateClient(String docId, String newName){
    return clients.doc(docId).update({
      'full_name':newName,
      'Age':30,
    });
  }

  //DELETE
  Future<void> deleteClient(String docId){
    return clients.doc(docId).delete();
  }

}