import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../Homepages/ProfilePageScreen/MyProfileMain.dart';
import '../Homepages/notification_page.dart';
import 'ManagePage.dart';

class Allactionpage extends StatefulWidget {
  final String docId;
  const Allactionpage({super.key,required this.docId});

  @override
  State<Allactionpage> createState() => _AllactionpageState();
}

class _AllactionpageState extends State<Allactionpage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          return Scaffold(

          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(width*0.025),
                  child: Row(
                    children: [
                      SizedBox(width:width*0.04),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Ensure proper navigation back
                        },
                        child: SvgPicture.asset('assets/images/chevron-left.svg'),
                      ),
                      SizedBox(width: width*0.2),
                      Text(
                        "All  Actions ",
                        style: TextStyle(
                            color: MyMateThemes.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: width*0.06),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.04),
                Row(
                  children: [
                    SizedBox(width: width*0.11),
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
                    SizedBox(width: width*0.11),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage(3,docId: widget.docId,)));
                      },
                      child: SvgPicture.asset(
                        'assets/images/inv.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: width*0.11),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage(3,docId: widget.docId,)));
                      },
                      child: SvgPicture.asset(
                        'assets/images/up.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: width*0.11),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage(3,docId: widget.docId,)));
                      },
                      child: SvgPicture.asset(
                        'assets/images/filter.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: width*0.11),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage(3,docId: widget.docId,)));
                      },
                      child: SvgPicture.asset(
                        'assets/images/boost.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: width*0.11),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage(3,docId: widget.docId,)));
                      },
                      child: SvgPicture.asset(
                        'assets/images/tok.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: width*0.11),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage(3,docId: widget.docId,)));
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
    );
  }
}
