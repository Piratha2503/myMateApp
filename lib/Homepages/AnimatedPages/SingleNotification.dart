import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:badges/badges.dart';

import '../Notification.dart';

class SingleNotificationPage extends StatelessWidget {
  int _selectedIndex = 0;
  late final int badgeValue = 6;

  String? get imageUrl => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage()));
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 80.0),
                  Text(
                    'Notification',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: MyMateThemes.textColor),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 15),
                Container(
                  height: 70,
                  width: 370,
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
                                  color: MyMateThemes
                                      .primaryColor, // Set the border color
                                  width: 2.0, // Set the border width
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: MyMateThemes.secondaryColor,
                                radius: 30,
                                // backgroundImage: NetworkImage(imageUrl),
                              ),
                            ),
                            if (badgeValue > 0)
                              Positioned(
                                top: -5, // Adjust the top position as needed
                                left: -5, // Adjust the right position as needed
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyMateThemes.primaryColor,
                                  ),
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
                        Container(
                          width: 200,
                          // alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        4.0), // Add bottom padding for spacing
                                child: Text(
                                  'First name Last name',
                                  style: TextStyle(
                                    color: MyMateThemes.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        4.0), // Add bottom padding for spacing
                              ),
                              Text(
                                ' Name asked your Contact Number',
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 15),
                Container(
                  height: 70,
                  width: 370,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: MyMateThemes.premiumAccent,
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
                        Container(
                          width: 200,
                          // alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        4.0), // Add bottom padding for spacing
                                child: Text(
                                  'First name Last name',
                                  style: TextStyle(
                                    color: MyMateThemes.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Text(
                                ' Name asked your Contact Number',
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 15),
                Container(
                  height: 100,
                  width: 370,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: MyMateThemes.primaryColor,
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
                                  color: MyMateThemes
                                      .premiumAccent, // Set the border color
                                  width: 2.0, // Set the border width
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: MyMateThemes.backgroundColor,
                                radius: 30,
                                // backgroundImage: NetworkImage(imageUrl),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 200,
                          // alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        4.0), // Add bottom padding for spacing
                                child: Text(
                                  'First name Last name',
                                  style: TextStyle(
                                    color: MyMateThemes.backgroundColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Text(
                                ' Name asked your Contact Number',
                                style: TextStyle(
                                  color: MyMateThemes.backgroundColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
