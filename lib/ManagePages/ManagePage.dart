import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/ProfilePageScreen/MyProfileMain.dart';
import 'package:mymateapp/ManagePages/AboutPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/ManagePages/AccountPage.dart';
import 'package:mymateapp/ManagePages/AllActionPage.dart';
import 'package:mymateapp/ManagePages/HelpPage.dart';
import 'package:mymateapp/ManagePages/SettingsPage.dart';
import 'package:mymateapp/ManagePages/SummaryPage.dart';

import '../Homepages/AddTokenPage.dart';
import 'CustomOutlineButton.dart';

class ManagePage extends StatefulWidget {
  final String docId;
  const ManagePage({super.key,required this.docId});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  bool _isSwitched = false;

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
            return AlertDialog(
              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(width*0.01),
                  ),
              contentPadding: EdgeInsets.all(width*0.12),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Turn on visible mode?",
                    style: TextStyle(
                      fontSize:width*0.04,
                      color: MyMateThemes.primaryColor,
                    ),
                  ),
                  SizedBox(height: height*0.04),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {

                            Navigator.of(context).pop();

                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(MyMateThemes.primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: height*0.025),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSwitched = false;
                        });
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
                        style: TextStyle(color: MyMateThemes.primaryColor),
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
      body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;
          return Stack(
            children: [
              // Main content (if any)
              Positioned.fill(
                child: Container(
                  color: Colors.white, // Background color
                ),
              ),
              // Fixed AppBar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: height*0.17,
                child:
                AppBar(
                  backgroundColor: MyMateThemes.primaryColor,
                  title: Text('Manage', style: TextStyle(color: Colors.white)),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Ensure proper navigation back

                    },
                  ),
                ),
              ),
              // Overlay card
              Positioned(
                top: kToolbarHeight +
                    height*0.03, // Adjust this value to position the card below the AppBar
                left: width*0.05,
                right: width*0.05,
                child: Card(

                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width*0.02),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05,vertical:constraints.maxHeight * 0.015 ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                    Container(
                    width: constraints.maxWidth * 0.18,
                      height: constraints.maxWidth * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyMateThemes.premiumAccent,
                          width: constraints.maxWidth * 0.01,
                        ),
                      ),
                    ),
                            SizedBox(width: width*0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.025),
                                        child: Text(
                                          'Name',
                                          style: TextStyle(
                                            fontSize: width*0.047,
                                            fontWeight: FontWeight.w500,
                                            color: MyMateThemes.textColor,
                                          ),
                                        ),
                                      ),

                                        Text(
                                          'Tokens left',
                                          style: TextStyle(
                                            fontSize: width*0.035,
                                            color: MyMateThemes.textColor,
                                          ),
                                        ),


                                Row(

                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/fire.svg',
                                          height: height*0.02,

                                          // width: 30,
                                          // height: 30,
                                        ),
                                        SizedBox(width:width*0.005),
                                        Text(
                                          '15',
                                          style: TextStyle(
                                            fontSize:width*0.047,
                                            fontWeight: FontWeight.w500,
                                            color: MyMateThemes.primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: width * 0.16),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            '+ Add Tokens',
                                            style: TextStyle(
                                              color: MyMateThemes.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),

                          ],
                        ),

                      ],
                    ),

                  ),
                ),
              ),
              Positioned(
                top: kToolbarHeight +
                    height*0.22, // Adjust this value based on your layout needs
                left: width*0.04,
                right: width*0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width*0.06),
                    Text(
                      'Profile invisible mode',
                      style: TextStyle(
                        fontSize:width*0.038,
                        fontWeight: FontWeight.w500,
                        color: MyMateThemes.primaryColor,
                      ),
                    ),
                    SizedBox(width: width*0.25),
                    // StyledSwitch(
                    //
                    //   onToggled:  (value) {
                    //      setState(() {
                    //   _isSwitched = value;
                    //   if (_isSwitched) {
                    //   _showCustomDialog();
                    //   }
                    //   });
                    //    },
                    //   initialValue: _isSwitched, // Maintain switch state
                    //   activeColor: MyMateThemes.secondaryColor, // Track color when ON
                    //   inactiveColor: MyMateThemes.textColor.withOpacity(0.1), // Track color when OFF
                    //   thumbColorActive: MyMateThemes.primaryColor, // Thumb color when ON
                    //   thumbColorInactive: MyMateThemes.textColor, // Thumb color when OFF
                    // ),

                    Transform.scale(
                      scaleY: 0.8,
                      scaleX: 0.9,

                      child: Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                            if (_isSwitched) {
                              _showCustomDialog();
                            }
                          });
                        },
                        activeColor: MyMateThemes.primaryColor,  // Color of the switch when ON
                        inactiveTrackColor: MyMateThemes.textColor.withOpacity(0.1), // Track color when OFF
                        activeTrackColor: MyMateThemes.secondaryColor,  // Track color when ON
                        inactiveThumbColor: MyMateThemes.textColor, // Thumb color when OFF
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: kToolbarHeight +
                   height*0.29, // Adjust this value based on your layout needs
                left: 18,
                right: 18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) => Summarypage(docId: widget.docId,)));
                          },
                          child: SvgPicture.asset(
                            'assets/images/Summary.svg',
                            height: height*0.071,

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) => Settingspage(docId: widget.docId,)));
                          },
                          child: SvgPicture.asset(
                            'assets/images/Settings.svg',
                            height: height*0.071,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context)=> Allactionpage(docId: widget.docId,)));
                          },
                          child: SvgPicture.asset(
                            'assets/images/Actions.svg',
                            height: height*0.071,

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) => AddTokenPage(docId: widget.docId,)));
                          },
                          child: SvgPicture.asset(
                            'assets/images/Token.svg',
                            height: height*0.071,

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) => Accountpage()));
                          },
                          child: SvgPicture.asset(
                            'assets/images/Account.svg',
                            height: height*0.071,

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) => Helppage(docId: widget.docId,)));
                          },
                          child: SvgPicture.asset(
                            'assets/images/Help.svg',
                            height: height*0.071,

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context)=> Aboutpage()));
                          },
                          child: SvgPicture.asset(
                            'assets/images/About.svg',
                            height: height*0.071,

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: width*0.03),
                        Text(
                          "Terms & Policies",
                          style: TextStyle(color: MyMateThemes.primaryColor),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: width*0.04),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/images/Fb.svg',
                              height: height*0.025
                          ),
                        ),
                        SizedBox(width:width*0.055),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/images/In.svg',
                          ),
                        ),
                        SizedBox(width:width*0.055),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/images/X.svg',
                              height: height*0.02

                          ),
                        ),
                        SizedBox(width:width*0.055),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/images/Tk.svg',
                              height: height*0.021

                          ),
                        ),
                        SizedBox(width:width*0.055),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/images/Yb.svg',
                              height: height*0.021

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01),

                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
