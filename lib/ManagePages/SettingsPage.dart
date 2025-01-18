import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../Homepages/Notification.dart';
import '../Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'ManagePage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settingspage extends StatefulWidget {
  final String docId;
  const Settingspage({super.key,required this.docId});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
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
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManagePage(docId: widget.docId,)));
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 110.0),
                  Text(
                    "Settings ",
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
                SizedBox(width: 40),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyMateThemes.premiumAccent, // Set the border color
                      width: 4.0, // Set the border width
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: MyMateThemes.containerColor,
                    radius: 35,
                    // backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  'Name',
                  style: TextStyle(color: MyMateThemes.textColor, fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 57),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  docId: widget.docId, selectedBottomBarIconIndex: 3,
                                )));
                  },
                  child: SvgPicture.asset(
                    'assets/images/Myprofile.svg',
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
                            builder: (context) => NotificationPage(3, docId: widget.docId,)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/Notification.svg',
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
                            builder: (context) => NotificationPage(3,docId:widget.docId)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/Language.svg',
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
                            builder: (context) => NotificationPage(3,docId:widget.docId)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/Photos.svg',
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
                            builder: (context) => NotificationPage(3,docId:widget.docId)));
                  },
                  child: SvgPicture.asset(
                    'assets/images/DelAcc.svg',
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
