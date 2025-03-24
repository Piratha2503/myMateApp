import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'package:mymateapp/Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'package:mymateapp/Homepages/explorePage/explorePageMain.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../Homepages/AddTokenPages/AddTokenMain.dart';
import '../Homepages/HomeScreenBeforeSubscribe.dart';

import '../Homepages/Notification.dart';
import '../Homepages/myMatePage/myMatePageMain.dart';
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
      case 2: NavigatorFunction(context, MyMatePage( docId: widget.docId, results: [], search: [],));
      case 3: NavigatorFunction(context, AddTokenMainPage( docId: widget.docId));
      case 4: Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage(docId: widget.docId,
        selectedBottomBarIconIndex: 4,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      LayoutBuilder(
          builder: (context, constraints) {
            // Read width and height from constraints to use for responsive sizing.
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
            return Expanded(child:
            SizedBox(
              //height: 96.h,
              // height: height * 0.1,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent, // Transparent to blend with page
                elevation: 0,
                showSelectedLabels: false, // Hides selected item labels
                showUnselectedLabels: false,// Removes shadow/border
                items: [

                  _buildBottomNavigationBarItem(
                      'assets/images/bhome.svg', 'Home', 0),
                  _buildBottomNavigationBarItem(
                      'assets/images/bexplore.svg', 'Explore', 1),
                  _buildBottomNavigationBarItem(
                      'assets/images/bheart.svg', 'myMate', 2),
                  _buildBottomNavigationBarItem(
                      'assets/images/bfire.svg', 'token', 3),

                  _buildBottomNavigationBarItem(
                      'assets/images/buser.svg', 'Profile', 4),
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
            ),
            );
          }
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