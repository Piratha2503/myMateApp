import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../Homepages/Notification.dart';
import '../Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'ManagePage.dart';

class Allactionpage extends StatefulWidget {
  const Allactionpage({super.key});

  @override
  State<Allactionpage> createState() => _AllactionpageState();
}

class _AllactionpageState extends State<Allactionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(width: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManagePage()));
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 70.0),
                  Text(
                    "All  Actions ",
                    style: TextStyle(
                        color: MyMateThemes.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 43),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  docId: '', selectedBottomBarIconIndex: 3,
                                )));
                  },
                  child: SvgPicture.asset(
                    'assets/images/Edpr.svg',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(3)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/inv.svg',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(3)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/up.svg',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(3)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/filter.svg',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(3)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/boost.svg',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(3)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/tok.svg',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(3)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/pay.svg',
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
