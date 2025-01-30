import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../BadgeWidget.dart';
import '../CompleteProfileScreen/CompleteProfileMain.dart';
import 'SubscribedHomeScreenWidgets.dart';

class SubscribedhomescreenBeforeProfileCompleted extends StatefulWidget {
  final String docId;
  const SubscribedhomescreenBeforeProfileCompleted({super.key,required this.docId});

  @override
  State<SubscribedhomescreenBeforeProfileCompleted> createState() =>
      _SubscribedhomescreenBeforeProfileCompletedState();
}

class _SubscribedhomescreenBeforeProfileCompletedState extends State<SubscribedhomescreenBeforeProfileCompleted> {
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

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 22),
        SizedBox(
          height: 50, //height of button
          width: 165, //width of button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfilePage(docId: widget.docId)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              // padding: EdgeInsets.all(10)
            ),
            child: Text(
              'Complete Profile ',
              style: TextStyle(color:Colors.white),
            ),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50, //height of button
          width: 164, //width of button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfilePage(docId: widget.docId,)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            child: Text('New Match', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Future<void> getClient() async{
    final data = await fetchUserById(widget.docId);
    data.isNotEmpty ?
    setState(() {
      name = data['full_name'] ?? "N/A";
    })
        : print("Data is Empty");
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
          _buildFooterRow(),

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
