import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Test extends StatefulWidget{
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();

}

class _TestState extends State<Test>{

  List<dynamic> httpResponse = [];
  bool isLoading = false;
  int page = 1;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(page,10);
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchData(page, 10);
      };
      
    });
  }
  Future<void> fetchData(int page, int limit) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final apiUrl = Uri.parse(
        "https://jsonplaceholder.typicode.com/comments?_page=$page&_limit=$limit");
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        setState(() {
          httpResponse.addAll(json.decode(response.body)); // Append new data
          this.page++; // Increment page after data is fetched
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
          controller: scrollController,
          itemCount: httpResponse.length + (isLoading ? 1 : 0), // Add an extra item for loader
          itemBuilder: (context, index) {
            if (index == httpResponse.length) {
              // Show loading indicator at the end of the list
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final item = httpResponse[index];


            return ListTile(
              title: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    )
                  )
                ),
                child: Column(

                  children: <Widget>[
                    Text(item['id'].toString()+":-"+item['name'],
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                      ),),
                    SizedBox(height: 5,),
                    Text(item['body'],
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 15,
                      ),),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            );

          }
      ),
    );
  }



}