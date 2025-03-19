import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateCommonBodies/RouterFunction.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'SingleNotification.dart';

class ChatPage extends StatelessWidget {
  final String docId;
  const ChatPage({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            UserDetails(screenWidth),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  String name = 'First Name Last Name';
                  String detail = 'Name asked your contact number';
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.015,
                    ),
                    child: GestureDetector(
                      onTap: () => NavigatorFunction(
                        context,
                        SingleNotificationPage(docId: docId),
                      ),
                      child: NotificationContainer(name, detail, screenWidth),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Padding UserDetails(double screenWidth) {
  return Padding(
    padding: EdgeInsets.all(screenWidth * 0.04),
    child: Row(
      children: [
        SvgPicture.asset(
          'assets/images/chevron-left.svg',
          width: screenWidth * 0.06,
        ),
        SizedBox(width: screenWidth * 0.2),
        Text(
          '@user240676',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: MyMateThemes.textColor,
          ),
        ),
      ],
    ),
  );
}

Container NotificationContainer(String name, String detail, double screenWidth) {
  return Container(
    height: screenWidth * 0.2,
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border:Border.all(color: Colors.grey)
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black12,
      //     blurRadius: 2.0,
      //     spreadRadius: 2.0,
      //     offset: Offset(0, 0),
      //   ),
      // ],
    ),
    child: Row(
      children: [
        SizedBox(width: screenWidth * 0.05),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: MyMateThemes.primaryColor,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: MyMateThemes.secondaryColor,
                radius: screenWidth * 0.08,
              ),
            ),
            // Positioned(
            //   top: -5,
            //   left: 5,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: MyMateThemes.primaryColor,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(width: screenWidth * 0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.01),
              child: Text(
                name,
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Text(
              detail,
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
