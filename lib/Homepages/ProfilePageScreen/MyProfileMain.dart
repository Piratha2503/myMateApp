import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileBody.dart';
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
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,

      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
        automaticallyImplyLeading: false,

        title: MyProfileMainAppbar(),
      ),

      body: MyProfileBody(docId: widget.docId),

      bottomNavigationBar: NavigationBar(),
    );
  }

  Widget MyProfileMainAppbar() {
    return SafeArea(
      child: Row(
        children: [
          // Back Button
          IconButton(
            icon: Icon(Icons.arrow_back, color: MyMateThemes.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          // Title
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: fetchUserById(widget.docId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(width: 20, height: 20);
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return Text(
                    'User',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  );
                }
                final fullName = snapshot.data!['full_name'] ?? 'Unknown';
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    fullName,
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          // Fire Icon and number
          SvgPicture.asset('assets/images/fire.svg', height: 20),
          const SizedBox(width: 4),
          Text(
            '78',
            style: TextStyle(color: MyMateThemes.textColor, fontSize: 16),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: MyMateThemes.primaryColor),
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
      }, docId: widget.docId,
    );
  }
}