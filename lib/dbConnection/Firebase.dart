import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

class Firebase{

  final CollectionReference clients = FirebaseFirestore.instance.collection('clients');
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<ClientProfile> myClients = [];

  //GET
  Stream<QuerySnapshot> getClients() {
    return clients.snapshots();
  }

  // GET BY ID
  Stream<DocumentSnapshot> getClientStreamById(String docId) {
    return clients.doc(docId).snapshots();
  }
  // GET BY phone
  Future<ClientProfile> getClientByMobile(int mobile) async{
    QuerySnapshot snapshot = await firebaseFirestore.collection('clients').where("mobile",isEqualTo: mobile).get();
    DocumentSnapshot documentSnapshot = snapshot.docs.first;
    return ClientProfile(
        full_name: documentSnapshot['full_name'],
        gender: documentSnapshot['gender'],
        name: documentSnapshot['last_name'],
        age: documentSnapshot['age'],
        status: "Married",
        occupation: documentSnapshot['occupation'],
        district: documentSnapshot['district'],
        imageUrl: documentSnapshot['image_url'],
        matchPercentage: "80%",
    );
  }

  // GET LIST
  Future<List<ClientProfile>> getClientList() async{
    QuerySnapshot querySnapshot = await clients.get();
    List<ClientProfile> clientList = querySnapshot.docs.map((doc){
      return ClientProfile(
          full_name: doc['full_name'],
          gender: doc['gender'],
          name: doc['last_name'],
          age: doc['age'],
          status: "Married",
          occupation: doc['occupation'],
          district: doc['district'],
          imageUrl: doc['image_url'],
          matchPercentage: "80%");
    }).toList();
    return clientList;
  }


  //GET LIST
  Stream<List<ClientProfile>> getClientsStream() {
    // Listen to real-time updates from Firestore
    return clients.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ClientProfile(
          full_name: doc['full_name'],
          gender: doc['gender'],
          name: doc['last_name'],
          age: doc['age'],
          status: "Married",
          occupation: doc['occupation'],
          district: doc['district'],
          imageUrl: doc['image_url'],
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
  Future<void> updateClient(String docId, ClientProfile clientProfile){
    return clients.doc(docId).update({
      'full_name': clientProfile.name,
      'age': clientProfile.age,
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

  //DELETE
  Future<void> deleteClient(String docId){
    return clients.doc(docId).delete();
  }

}

// ninja API key:- plNl8wzftPNAcKp/Beu9Dw==BlJ7oDJKA5ZAXHzx