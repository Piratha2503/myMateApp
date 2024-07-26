import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:badges/badges.dart';

import '../ManagePages/HelpPage.dart';
import 'Notification.dart';

class SingleHelpPage extends StatefulWidget {
  @override
  _SingleHelpPageState createState() => _SingleHelpPageState();
}

class _SingleHelpPageState extends State<SingleHelpPage> {
  int _selectedIndex = 0;
  late final int badgeValue = 6;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapping outside the TextField
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
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
                                  builder: (context) => Helppage()));
                        },
                        child:
                            SvgPicture.asset('assets/images/chevron-left.svg'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 185),
                    SizedBox(height: 10),
                    SvgPicture.asset('assets/images/headphone.svg'),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 115),
                    Container(
                      height: 45,
                      width: 158,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 15,
                            left: 50,
                            child: Text(
                              'MyMate',
                              style: TextStyle(
                                fontSize: 12,
                                color: MyMateThemes.textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 45),
                    SvgPicture.asset('assets/images/headphone.svg'),
                    SizedBox(width: 10),
                    Container(
                      height: 70,
                      width: 260,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: MyMateThemes.secondaryColor,
                        borderRadius: BorderRadius.circular(15.0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi User, I'm MyMate , Your automated "
                                    "virtual assistant. How may I help you "
                                    "today?",
                                    style: TextStyle(
                                      color: MyMateThemes.textColor,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
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
                SizedBox(height: 440),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyMateThemes.secondaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Keep your questions short & Simple",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  // Handle the send action here
                                  print(_controller.text);
                                  _controller
                                      .clear(); // Clear the text field after sending
                                },
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                // Trigger a rebuild to move the TextField up
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
