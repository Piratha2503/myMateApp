import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/ManagePages/AboutPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../Homepages/bottom_navigation_bar.dart';
import 'package:responsive_screen_type/responsive_screen_type.dart';
import 'package:mymateapp/ManagePages/AboutPage.dart';
import 'package:mymateapp/ManagePages/AccountPage.dart';
import 'package:mymateapp/ManagePages/AllActionPage.dart';
import 'package:mymateapp/ManagePages/HelpPage.dart';
import 'package:mymateapp/ManagePages/SettingsPage.dart';
import 'package:mymateapp/ManagePages/SummaryPage.dart';
import 'package:mymateapp/ManagePages/TokenPage.dart';
import 'package:mymateapp/ManagePages/ManagePage.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  bool _isSwitched = false;

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.all(20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Turn on visible mode?",
                style: TextStyle(
                  fontSize: 18.0,
                  color: MyMateThemes.primaryGreen,
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/images/ok.svg',
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    //_isSwitched = false;
                  },
                  child: SvgPicture.asset(
                    'assets/images/cancel.svg',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content (if any)
          Positioned.fill(
            child: Container(
              color: MyMateThemes.backgroundWhite, // Background color
            ),
          ),
          // Fixed AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: MyMateThemes.primaryGreen,
              title: Text('Manage', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {},
              ),
            ),
            height: 150,
          ),
          // Overlay card
          Positioned(
            top: kToolbarHeight +
                40, // Adjust this value to position the card below the AppBar
            left: 18,
            right: 18,
            child: Card(
              color: MyMateThemes.backgroundWhite,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/smc.svg',
                      // width: 30,
                      // height: 30,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MyMateThemes.textGreen,
                            ),
                          ),
                          // Text(
                          //   'Tokens left',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: MyMateThemes.textGreen,
                          //   ),
                          // ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Text(
                                'Tokens left',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: MyMateThemes.textGreen,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/Group 2177.svg',
                                // width: 30,
                                // height: 30,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '15',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyMateThemes.primaryGreen,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  '+ Add Tokens',
                                  style: TextStyle(
                                    color: MyMateThemes.primaryGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight +
                200, // Adjust this value based on your layout needs
            left: 18,
            right: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Profile invisible mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MyMateThemes.primaryGreen,
                  ),
                ),
                SizedBox(width: 80),
                Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      if (_isSwitched) {
                        _showCustomDialog();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: kToolbarHeight +
                250, // Adjust this value based on your layout needs
            left: 18,
            right: 18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Summarypage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Summary.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settingspage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Settings.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Allactionpage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Actions.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tokenpage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Token.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Accountpage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Account.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Helppage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/Help.svg',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Aboutpage()));
                      },
                      child: SvgPicture.asset(
                        'assets/images/About.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Terms & Policies",
                      style: TextStyle(color: MyMateThemes.primaryGreen),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/Fb.svg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/In.svg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/X.svg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/Tk.svg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/Yb.svg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}