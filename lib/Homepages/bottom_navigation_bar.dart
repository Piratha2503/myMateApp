import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

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
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String assetName, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetName,
        color: _selectedIndex == index
            ? MyMateThemes.primaryColor
            : MyMateThemes.secondaryColor,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyMateThemes.backgroundColor,
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
          widget.onItemTapped(index);
        },
      ),
    );
  }
}
