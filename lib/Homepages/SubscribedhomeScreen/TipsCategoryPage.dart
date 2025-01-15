import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import 'TipsPage.dart';

class TipsCategoryPage extends StatefulWidget {
  @override
  _TipsCategoryPageState createState() => _TipsCategoryPageState();
}

class _TipsCategoryPageState extends State<TipsCategoryPage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> categories = [
    {'name': 'Purchasing Tokens'},
    {'name': 'Completing Profile'},
    {'name': 'Accept Requests'},
    {'name': 'View Profiles'},
    {'name': 'View Profiles'},
    {'name': 'View Profiles'},

    // {'name': 'Indonesian Pizza', 'time': '25 Min'},
    // {'name': 'Malaysian String Hoppers', 'time': '45 Min'},
    // {'name': 'Indian Curry', 'time': '35 Min'},
    // {'name': 'Thai Noodles', 'time': '20 Min'},
  ];

  Widget TipsItem(Map<String, dynamic> category, int index) {
    return Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TipsPage()),
              );
            },
            child:   Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: MyMateThemes.textColor,
                          ),
                        ),
                        // Text(
                        //   category['time'],
                        //   style: TextStyle(
                        //       fontSize: 14,
                        //     fontWeight: FontWeight.w500,
                        //     color: Sure365Themes.secondaryColor,
                        //   ),
                        // ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],


    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyMateThemes.backgroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Tips Category",
          style: TextStyle(color: MyMateThemes.backgroundColor),
        ),
        backgroundColor: MyMateThemes.primaryColor,
      ),
      body:
      Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == categories.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 6.0),

                  );
                }
                return TipsItem(categories[index], index);
              },
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),

      // bottomNavigationBar: CustomBottomNavigationBar(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //     // Handle navigation here based on the index
      //   },
      // ),
    );
  }
}