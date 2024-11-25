import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileBody.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../../dbConnection/Firebase.dart';
import '../BadgeWidget.dart';
import 'MyProfileWidgets.dart';

class ProfilePage extends StatefulWidget {
  final String docId;
  final int selectedBottomBarIconIndex;
  const ProfilePage({required this.selectedBottomBarIconIndex, required this.docId, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState(this.selectedBottomBarIconIndex);
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final int selectedBottomBarIconIndex;

  int _selectedButtonIndex = 0;

  _ProfilePageState(this.selectedBottomBarIconIndex);

  bool isButtonSelected(int index) => _selectedButtonIndex == index;

  bool _isSmall = false;
  int _selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();
  int selectedAlcoholIndex = 0;
  int selectedCookingIndex = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isSmall = !_isSmall;
    });
  }

  void _scrollListener() {
    double containerHeight = 1000.0;
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,

      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
        title: MyProfileMainAppbar(),
      ),

      body: MyProfileBody(docId: widget.docId),

      bottomNavigationBar: NavigationBar(),
    );
  }

  Widget MyProfileMainAppbar(){
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 50),
              Text(
                '@user240676',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 40),
              BadgeWidget(
                  assetPath: 'assets/images/Group 2157.svg', badgeValue: 1),
              SizedBox(width: 25),
              BadgeWidget(
                  assetPath: 'assets/images/Group 2153.svg', badgeValue: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget NavigationBar() {
    return CustomBottomNavigationBar(
      selectedIndex: this.selectedBottomBarIconIndex,
      onItemTapped: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation here based on the index
      },
    );
  }
}
