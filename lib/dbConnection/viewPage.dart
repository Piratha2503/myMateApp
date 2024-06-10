import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/dbConnection/Firebase.dart';
import '../MyMateThemes.dart';

class viewPage extends StatefulWidget {
  final String docId;

  const viewPage({required this.docId, Key? key}) : super(key: key);

  @override
  State<viewPage> createState() => _viewPageState();
}

class _viewPageState extends State<viewPage> {
  String full_name = "";
  String gender = "";
  String education = "";
  String district = "";
  String occupation = "";
  String mobile = "";
  String religion = "";

  final Firebase firebase = Firebase();

  @override
  void initState() {
    super.initState();
    getClient();
  }

  Future<void> getClient() async {
    DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();

    setState(() {
      full_name = client['full_name'];
      gender = client['gender'];
      education = client['education'];
      district = client['district'];
      occupation = client['occupation'];
      mobile = client['mobile'].toString();
      religion = client['religion'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyMateThemes.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Table(

            children: [
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Name :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(full_name, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                  )))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Gender :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(gender, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                  )))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Education :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(education, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                  )))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('District :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(district, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                  )))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Occupation :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0),
                      child: Text(occupation, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                        color: Colors.orange
                      )))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Mobile :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(mobile, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                  )))),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Religion :-', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo
                  )))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(religion, style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange
                  )))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
