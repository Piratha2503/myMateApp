import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

class Firebase{

  final CollectionReference clients = FirebaseFirestore.instance.collection('clients');

  List<List<ClientProfile>> clientList = [];
  List<ClientProfile> myClients = [];

  //GET
  Stream<QuerySnapshot> getClients() {
    return clients.snapshots();
  }

  //GET LIST
  Stream<List<ClientProfile>> getClientsStream() {
    // Listen to real-time updates from Firestore
    return clients.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ClientProfile(
          name: doc['full_name'],
          age: doc['age'],
          status: "Married",
          occupation: doc['occupation'],
          district: doc['district'],
          imageUrl: "https://piratha.com/images/Piratha.jpg",
          matchPercentage: "80%",
        );
      }).toList();
    });
  }

  //POST
  Future<void> addClient(){

    return clients.add({
      'full_name': "Aravinthan Sharan",
      'age': 30,
      'dob': '28-03-1992',
      'mobile': 0778741623,
      'mobile_countryCode': 'lk',
      'gender': 'male',
      'civil_status': 'single',
      'employment_type': 'professional',
      'occupation':'Driver',
      'height':154,
      'district':'Kandy',
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