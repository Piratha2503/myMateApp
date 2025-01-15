import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateCommonBodies/RouterFunction.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'SingleNotification.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';

class NotificationPage extends StatelessWidget {
    final int selectedBottomBarIconIndex;
    const NotificationPage(this.selectedBottomBarIconIndex,{super.key});

  String? get imageUrl => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            UserDetails(),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 16, // Number of items in the list
                itemBuilder: (context, index) {
                  String name = 'First Name Last Name';
                  String detail = 'Name asked your contact number';
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: GestureDetector(
                      onTap: () => NavigatorFunction(context, SingleNotificationPage()),
                      child: NotificationContainer(name,detail),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   selectedIndex: this.selectedBottomBarIconIndex,
      //   onItemTapped: (index) {
      //     // setState(() {
      //     //   _selectedIndex = index;
      //     // });
      //     // Handle navigation here based on the index
      //   },
      // ),
    );
  }
}

Padding UserDetails(){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        SvgPicture.asset('assets/images/chevron-left.svg'),
        SizedBox(width: 80.0),
        Text(
          '@user240676',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: MyMateThemes.textColor),
        ),
      ],
    ),
  );
}

Container NotificationContainer(String name, String detail){

  final int badgeValue = 6;

  return Container(
    height: 70,
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2.0,
          spreadRadius: 2.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          SizedBox(width: 20),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyMateThemes.primaryColor, // Set the border color
                    width: 2.0, // Set the border width
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor:
                  MyMateThemes.secondaryColor,
                  radius: 30,
                  // backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              if (badgeValue > 0)
                Positioned(
                  top: -5, // Adjust the top position as needed
                  left: -5, // Adjust the right position as needed
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration( shape: BoxShape.circle, color: MyMateThemes.primaryColor,),
                    child: Text(
                      badgeValue.toString(),
                      style: TextStyle(
                        color: MyMateThemes.backgroundColor,
                        fontSize: badgeValue > 9 ? 12 : 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0), // Add bottom padding for spacing
                child: Text(
                  name,
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),),
              Text(
                detail,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ]
        ),
      ],
    ),
  );
}
