import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDetails{

  String name = "";
  int age = 0;
  String dob = "";
  int mobile = 0;
  String countryCode = "";
  String gender = "";


  //'full_name': "Mannavarasan Venukanth",
  //'age': 31,
  //'dob': '28-03-1992',
  //'mobile': 0778741623,
  //'mobile_countryCode': 'lk',
  //'gender': 'male',
  /*
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
  */
}

class Firebase{

  final CollectionReference clients =
  FirebaseFirestore.instance.collection('clients');

  List<List<dynamic>> clientList = [];

  //GET
  Stream<QuerySnapshot> getClients() {
    return clients.snapshots();
  }

  //GET LIST
  Future<void> getClientsList() async{
    QuerySnapshot snapshot = await clients.get() ;
    snapshot.docs.map((doc){
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
  Future<void> addClient(
      List<Object> clientDetails
      ){

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