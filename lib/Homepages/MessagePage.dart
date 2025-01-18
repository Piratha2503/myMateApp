import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import 'Notification.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';

class MessagePage extends StatefulWidget {
  final String docId;
  const MessagePage({super.key,required this.docId});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // String full_name = "";
  String selectedText = '';

  String selectedReligion = '';
  final int _selectedIndex = 0;
  late final int badgeValue = 6;

  String? get imageUrl => null;

  // @override
  // void initState() {
  //   super.initState();
  //   // Show the popup dialog when the page loads
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showPopupDialog();
  //   });
  // }

  Widget buildContainer(String text, String category) {
    final isSelected = (category == 'religion' && selectedReligion == text);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (category == 'religion') {
            selectedReligion = text;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? MyMateThemes.primaryColor
              : MyMateThemes.secondaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : MyMateThemes.primaryColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1
          ),
        ),
      ),
    );
  }

  // void _showPopupDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return
  //
  //     },
  //   );
  // }

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
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage(3,docId: widget.docId,)));
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 100.0),
                  Text(
                    '@user240676',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: MyMateThemes.textColor),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 15),
                Container(
                  height: 100,
                  width: 360,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                                  width: 5.0, // Set the border width
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: MyMateThemes.secondaryColor,
                                radius: 30,
                                // backgroundImage: NetworkImage(imageUrl),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          // alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Text(
                              //   full_name,
                              //   style: TextStyle(
                              //     color: MyMateThemes.primaryColor,
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              Text(
                                'Full Name',
                                style: TextStyle(
                                  color: MyMateThemes.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Special Mention (Optional)',
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
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
            Divider(),
           Spacer(),
            Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        buildContainer('Contact', 'religion'),
                        SizedBox(width: 10),
                        buildContainer('Hobby', 'religion'),
                        SizedBox(width: 10),
                        buildContainer('Favourites', 'religion'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildContainer('Alcohol', 'religion'),
                        SizedBox(width: 10),
                        buildContainer('Sports', 'religion'),
                        SizedBox(width: 10),
                        buildContainer('Cooking', 'religion'),
                      ],
                    ),
                    SizedBox(height: 50),
                ],
    ),
    ],
    ),
    ),
    );
  }
}
