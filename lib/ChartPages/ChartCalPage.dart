import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:mymateapp/MyMateThemes.dart';

class ChartCalPage extends StatefulWidget {
  const ChartCalPage({super.key});

  @override
  State<ChartCalPage> createState() => _ChartCalPageState();
}

class _ChartCalPageState extends State<ChartCalPage> {
  List<dynamic> users = [];
  final TextEditingController _typeAheadController = TextEditingController();

  Future<List<String>> _fetchCityNames(String query) async {
    final url =
        "http://192.168.1.55:8092/city/findcities?cityName=$query&countryCode=lk";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = jsonDecode(response.body);
      return jsonBody.map((user) => user as String).toList();
    } else {
      throw Exception('Failed to load city names');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
      ),
      body: Center(
        child: TypeAheadField<String>(
          controller: _typeAheadController,
          itemBuilder: (context, String suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSelected: (String suggestion) {
            _typeAheadController.text = suggestion;
          },
          suggestionsCallback: (pattern) async {
            return await _fetchCityNames(pattern);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(
          Icons.account_tree,
          size: 25,
        ),
      ),
    );
  }

  void onPressed() async {
    print("Hi");
    const url =
        "http://192.168.1.55:8092/city/findcities?cityName=gall&countryCode=lk";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    setState(() {
      users = jsonBody;
    });
  }
}

/*
ListView.builder(

 */
