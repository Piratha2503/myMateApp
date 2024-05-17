
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mymateapp/MyMateThemes.dart';

class ChartCalPage extends StatefulWidget{
  const ChartCalPage({super.key});

  @override
  State<ChartCalPage> createState() => _ChartCalPageState();

}

class _ChartCalPageState extends State<ChartCalPage>{
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundWhite,
      ),
      body: ListView.builder(

          itemCount: users.length,
          itemBuilder: (context,index){
            final user = users[index];
            final email = user['email'];
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(

              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 5,
              ),
              height: 50,
              width: 250,
              decoration: const BoxDecoration(
                color: Colors.grey,
                boxShadow: CupertinoContextMenu.kEndBoxShadow,
                shape: BoxShape.rectangle,

              ),
              child: Text(email,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
            ),);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.account_tree,size: 25,),
      ),
    );
  }
  void onPressed() async{
    print("Hi");
    const url = "https://randomuser.me/api/?results=50";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    setState(() {
      users = jsonBody["results"];
    });

  }
}