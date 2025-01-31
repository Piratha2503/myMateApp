import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileMain.dart';

import 'package:mymateapp/Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'package:mymateapp/Homepages/explorePage/explorePageMain.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../Homepages/HomeScreenBeforeSubscibe.dart';

import '../Homepages/Notification.dart';
import 'RouterFunction.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final String docId;

  const CustomBottomNavigationBar({
    super.key,
    required this.docId,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;


  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void onTab(int index){
    switch(index){
      case 0: NavigatorFunction(context, SubscribedhomescreenStructuredPage(docId: widget.docId,));
      case 1: NavigatorFunction(context, ExplorePage(results: [], docId: widget.docId,search: [],));
      case 2: NavigatorFunction(context, NotificationPage(index, docId: widget.docId,));
      case 3: Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage(docId: widget.docId,
        selectedBottomBarIconIndex: 3,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      height: 79,

      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [

          _buildBottomNavigationBarItem(
              'assets/images/Group 2141.svg', 'Home', 0),
          _buildBottomNavigationBarItem(
              'assets/images/Group 2142.svg', 'Explore', 1),
          _buildBottomNavigationBarItem(
              'assets/images/Group 2143.svg', 'Notifications', 2),
          _buildBottomNavigationBarItem(
              'assets/images/Group 2144.svg', 'Profile', 3),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyMateThemes.primaryColor,
        unselectedItemColor: MyMateThemes.secondaryColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          onTab(index);
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String assetName,
      String label,
      int index) {
    return
      BottomNavigationBarItem(
        icon:SvgPicture.asset(
            assetName,
            // height: 24, // Ensure a fixed height for proper alignment
            // width: 24,
            color: _selectedIndex == index
                ? MyMateThemes.primaryColor
                : MyMateThemes.secondaryColor,
          ),

        label: '',
      )
    ;
  }
}
