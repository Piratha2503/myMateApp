import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/Profiles/EditGalleryScreen.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../Homepages/ProfilePageScreen/MyProfileMain.dart';
import '../Homepages/notification_page.dart';
import 'ManagePage.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Settingspage extends StatefulWidget {
  final String docId;
  const Settingspage({super.key,required this.docId});

  @override
  State<Settingspage> createState() => _SettingspageState();
}



class _SettingspageState extends State<Settingspage> {

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(width*0.01),
                ),
                contentPadding: EdgeInsets.all(width*0.1),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Do you want to delete this account ?",
                      style: TextStyle(
                        fontSize:width*0.035,
                        color: MyMateThemes.textColor,
                      ),
                    ),
                    SizedBox(height: height*0.04),
                    Container(
                      width: width * 0.6,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red.withOpacity(0.8),
                          width:width * 0.001, // Use constraints
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),

                    SizedBox(height: height*0.025),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.07,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(MyMateThemes.secondaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: MyMateThemes.textColor),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }
        );
      },
    );
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

          return SafeArea(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Row(
                    children: [
                      SizedBox(width: width*0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Ensure proper navigation back

                        },
                        child: SvgPicture.asset('assets/images/chevron-left.svg'),
                      ),
                      SizedBox(width: width*0.3),
                      Text(
                        "Settings ",
                        style: TextStyle(
                            color: MyMateThemes.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: width*0.055),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:height*0.05),
                Row(
                  children: [
                    SizedBox(width: width*0.08),
                    Container(
                      width: constraints.maxWidth * 0.2,
                      height: constraints.maxWidth * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyMateThemes.secondaryColor,
                        border: Border.all(
                          color: MyMateThemes.premiumAccent,
                          width: constraints.maxWidth * 0.01,
                        ),
                      ),
                    ),
                    SizedBox(width:width*0.07),
                    Text(
                      'Name',
                      style: TextStyle(color: MyMateThemes.textColor, fontSize: width*0.055),
                    )
                  ],
                ),
                SizedBox(height:height*0.08),
                Row(
                  children: [
                    SizedBox(width:width*0.15),
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
                    SizedBox(width:width*0.1),
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
                    SizedBox(width:width*0.1),
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
                    SizedBox(width:width*0.1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditGalleryScreen(docId:widget.docId, onSave: () {  })));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Photos.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width:width*0.1),
                    GestureDetector(
                      onTap: () {
                        _showDeleteDialog();
                      },
                      child: SvgPicture.asset(
                        'assets/images/DelAcc.svg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}


