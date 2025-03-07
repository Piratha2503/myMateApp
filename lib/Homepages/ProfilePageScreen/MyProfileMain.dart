import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  bool _isSmall = true;

  int _selectedIndex = 0;

  int badgeValue1 = 2;
  int badgeValue2 = 10;

  final ScrollController _scrollController = ScrollController();
  int selectedAlcoholIndex = 0;
  int selectedCookingIndex = 0;

  @override
  void initState() {
    super.initState();
    print("DocId of ProfilePage : ${widget.docId}");
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

  Widget MyProfileMainAppbar() {

    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,

      title: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.2), // Adjust spacing dynamically
                Text(
                  '@user240676',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                SvgPicture.asset('assets/images/fire.svg',height: MediaQuery.of(context).size.height * 0.02,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),

                Text('78',style: TextStyle(color: MyMateThemes.textColor,fontSize:MediaQuery.of(context).size.width * 0.05 ),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu, color: MyMateThemes.primaryColor),
                ),
                  //
                  //
                  // BadgeWidget(assetPath: 'assets/images/bell.svg', badgeValue: badgeValue1),
                  // SizedBox(width: MediaQuery.of(context).size.width  * 0.045),
                  // BadgeWidget(assetPath: 'assets/images/Group 2157.svg', badgeValue: badgeValue2),
                  // SizedBox(width:MediaQuery.of(context).size.width  * 0.045),

              ],
            ),
          ],
        ),
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
      }, docId: widget.docId,
    );
  }
}