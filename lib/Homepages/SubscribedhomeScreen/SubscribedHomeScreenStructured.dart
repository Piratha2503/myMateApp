import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import 'SubscribedHomeScreenWidgets.dart';

class SubscribedhomescreenStructuredPage extends StatefulWidget {
  const SubscribedhomescreenStructuredPage({super.key});

  @override
  State<SubscribedhomescreenStructuredPage> createState() =>
      _SubscribedhomescreenStructuredPageState();
}

class _SubscribedhomescreenStructuredPageState extends State<SubscribedhomescreenStructuredPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Show the popup dialog when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopupDialog();
    });
  }

  void _showPopupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SubscribedhomescreenStructuredPagePopupDialogWidget(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
        appBar: SubscribedhomescreenStructuredPageAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         SubscribedhomescreenStructuredPageTotalMatchColumn(context),
          Center(
            child: Text(
              'View Matches',
              style: TextStyle(
                color: MyMateThemes.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 15,),
          SubscribedhomescreenStructuredPageCarouselSlider(context,context),
          SizedBox(height: 30),
          SubscribedhomescreenStructuredPageTokenContainers(context),
          SizedBox(height: 20),

        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation here based on the index
        },
      ),
    );
  }
}
