import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/Homepages/FirstWelcomeScreen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex; // Declare _selectedIndex here

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.selectedIndex; // Initialize _selectedIndex in initState
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyMateThemes.backgroundWhite,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Group 2141.svg',
              // width: 28.04,
              // height: 28,
              color: _selectedIndex == 0 // Use _selectedIndex here
                  ? MyMateThemes.primaryGreen
                  : MyMateThemes.secondaryGreen,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Group 2142.svg',
              // width: 32,
              // height: 42,
              color: _selectedIndex == 1 // Use _selectedIndex here
                  ? MyMateThemes.primaryGreen
                  : MyMateThemes.secondaryGreen,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Group 2143.svg',

              // width: 24.5,
              // height: 28,
              color: _selectedIndex == 2 // Use _selectedIndex here
                  ? MyMateThemes.primaryGreen
                  : MyMateThemes.secondaryGreen,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Group 2144.svg',
              // width: 26.13,
              // height: 28,
              color: _selectedIndex == 3 // Use _selectedIndex here
                  ? MyMateThemes.primaryGreen
                  : MyMateThemes.secondaryGreen,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Use _selectedIndex here
        selectedItemColor: MyMateThemes.primaryGreen,
        unselectedItemColor: MyMateThemes.secondaryGreen,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update _selectedIndex when tapped
          });
          widget.onItemTapped(index); // Call the provided callback function
        },
      ),
    );
  }
}
