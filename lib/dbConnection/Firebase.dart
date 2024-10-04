import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

class Firebase{

  final CollectionReference clients =
  FirebaseFirestore.instance.collection('clients');

  List<List<ClientProfile>> clientList = [];

  //GET
  Stream<QuerySnapshot> getClients() {
    return clients.snapshots();
  }

  //GET LIST
  Future<void> getClientsList() async{

    QuerySnapshot snapshot = await clients.get() ;
    snapshot.docs.map((doc){
      //ClientProfile clientProfile = ClientProfile(name: name, age: age, status: status, occupation: occupation, district: district, imageUrl: imageUrl, matchPercentage: matchPercentage)
     // clientProfile.name = doc['full_name'];
      clientList.add([
        doc['full_name'],
        doc['gender'],
        doc['education'],
        doc['district'],
        doc['occupation'],
        doc['mobile'],
        doc['religion'],
        doc['age'],
        doc['dob'],
      ]);
    });

  }

  //POST
  Future<void> addClient(){

    return clients.add({
      'full_name': "Mannavarasan Venukanth",
      'age': 31,
      'dob': '28-03-1992',
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