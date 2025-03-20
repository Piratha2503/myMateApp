import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileBody.dart';
import 'package:mymateapp/ManagePages/ManagePage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../../../MyMateCommonBodies/MyMateBottomBar.dart';
import '../../../dbConnection/Firebase.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
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
    return LayoutBuilder(
        builder: (context, constraints) {
          // Read width and height from constraints to use for responsive sizing.
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,

            title: MyProfileMainAppbar(),
          ),

          body: MyProfileBody(docId: widget.docId),

          bottomNavigationBar: NavigationBar(),
        );
      }
    );
  }

  Widget MyProfileMainAppbar() {

    return SafeArea(

      child: LayoutBuilder(
          builder: (context, constraints) {
            // Read width and height from constraints to use for responsive sizing.
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
          return Row(
            children: [
              // Back Button
              // IconButton(
              //   icon: Icon(Icons.arrow_back, color: MyMateThemes.primaryColor),
              //   onPressed: () => Navigator.pop(context),
              // ),
             SizedBox(width:width*0.35),
              // Title
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: fetchUserById(widget.docId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(width: width*0.015, height: height*0.015);
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Text(
                        'User',
                        style: TextStyle(color: Colors.red, fontSize: width*0.02),
                      );
                    }
                    final fullName = snapshot.data!['full_name'] ?? 'Unknown';
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        fullName,
                        style: TextStyle(
                          color: MyMateThemes.textColor,
                          fontSize: width*0.045,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: false,
                        overflow: TextOverflow.visible,
                      ),
                    );
                  },
                ),
              ),
               SizedBox(width: width*0.02),
              // Fire Icon and number
              SvgPicture.asset('assets/images/fire.svg', width: width*0.04),
              SizedBox(width: width*0.01),
              Text(
                '78',
                style: TextStyle(color: MyMateThemes.textColor, fontSize: width*0.045),
              ),
           // SizedBox(width:width*0.01),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => ManagePage(docId: 'E0JFHhK2x6Gq2Ac6XSyP',),
                    ),
                  );
                },
                icon: Icon(Icons.menu,size: width*0.065, color: MyMateThemes.primaryColor),
              ),
            ],
          );
        }
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