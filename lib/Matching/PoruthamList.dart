import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/CheckMatch.dart';
import '../dbConnection/Firebase.dart';
import 'Rasi.dart';

class PoruthamList extends StatefulWidget{

  PoruthamList({super.key});

  String girlNadchathiram = "Bharani";
  String boyNadchathiram = "Pusham";
  String girlRasi = "Kadagam";
  String boyRasi = "Kanni";
  String user = "TestUser";

  final Firebase firebase = Firebase();

  Future<void> getGirlClient() async{
    String docId = "EuzvIHpObxhHjOo9iutc";
    DocumentSnapshot client = await firebase.clients.doc(docId).get();
      girlNadchathiram = client["Nadchathiram"];
      girlRasi = client["Rasi"];
      user = client["full_name"];
  }

  @override
  void initState(){

    getGirlClient();

  }

  static final List<Map<String, String>> poruthamList = [
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Dina porutham',
      'status': MatchingCalculation.checkThinaMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Gana porutham',
      'status': MatchingCalculation.checkKanaMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString()
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Stree Deergha porutham',
      'status': 'Not Satisfactory'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Mahendra porutham 1',
      'status': 'Good'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Yoni porutham',
      'status': MatchingCalculation.checkYoniMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Veda porutham',
      'status': MatchingCalculation.checkVethaiMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Rajju porutham',
      'status': MatchingCalculation.checkRachuMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Rasi porutham',
      'status': MatchingCalculation.checkRasiMatch(PoruthamList().girlRasi, PoruthamList().boyRasi).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Rasiathipathy porutham',
      'status': 'Good'
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Vasya porutham',
      'status': MatchingCalculation.checkVasyaMatch(PoruthamList().girlRasi, PoruthamList().boyRasi).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Dina porutham',
      'status': MatchingCalculation.checkThinaMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Mahendra porutham 2',
      'status': 'Good'
    },
  ];


  @override
  State<PoruthamList> createState() => _PoruthamListState();
}

class _PoruthamListState extends State<PoruthamList>{

  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}

