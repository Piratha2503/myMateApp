import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../BadgeWidget.dart';
import '../CompleteProfileScreen/CompleteProfileMain.dart';
import 'SubscribedHomeScreenWidgets.dart';

class SubscribedhomescreenStructuredPage extends StatefulWidget {
  final String docId;
  const SubscribedhomescreenStructuredPage({super.key,required this.docId});

  @override
  State<SubscribedhomescreenStructuredPage> createState() =>
      _SubscribedhomescreenStructuredPageState();
}

class _SubscribedhomescreenStructuredPageState extends State<SubscribedhomescreenStructuredPage> {
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    getClient();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopupDialog();
      print("Subscribe HomeScreen docId:- ${widget.docId}");
    });
  }

  int badgeValue1 = 2;
  int badgeValue2 = 10;
  String name = 'Your Name';

  Future<void> getClient() async {
    final data = await fetchUserById(widget.docId);

    if (data.isNotEmpty) {
      setState(() {
        name = data['full_name'] ?? "N/A";
      });

      final completeProfilePending = data['completeProfilePending'];
      if (completeProfilePending != null) {
        if (completeProfilePending['_page1_complete'] == false) {
          _navigateToCompleteProfilePage(0);
        } else if (completeProfilePending['_page2_complete'] == false) {
          _navigateToCompleteProfilePage(2);
        } else if (completeProfilePending['_page3_complete'] == false) {
          _navigateToCompleteProfilePage(3);
        }
      }
    } else {
      print("Data is Empty");
    }
  }

  void _navigateToCompleteProfilePage(int pageIndex) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CompleteProfilePage(
          docId: widget.docId,
          initialPageIndex: pageIndex, // Pass the specific incomplete page index
        ),
      ),
    );
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
        appBar: AppBar(
          title:  CommonTextStyleForPage(name, MyMateThemes.textColor, FontWeight.w700, 20,),
          actions: <Widget>[
            SizedBox(width: 60),
            BadgeWidget(
                assetPath: 'assets/images/Group 2157.svg',
                badgeValue: badgeValue1),
            SizedBox(width: 25),
            BadgeWidget(
                assetPath: 'assets/images/Group 2153.svg',
                badgeValue: badgeValue2),
            SizedBox( width: 25, )
          ],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         SubscribedhomescreenStructuredPageTotalMatchColumn(context,widget.docId),
          Center(
            child: Text(
              'View Matches',
              style: TextStyle(
                color: MyMateThemes.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20,),
          SubscribeHomeScreenStructuredPageCarouselSliders(docId: widget.docId,),
          SizedBox(height: 30),
          SubscribedhomescreenStructuredPageTokenContainers(context,widget.docId),
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
        }, docId: widget.docId,
      ),
    );
  }
}
