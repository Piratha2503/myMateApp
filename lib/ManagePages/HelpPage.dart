import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Homepages/SingleHelp.dart';
import '../MyMateThemes.dart';
import 'ManagePage.dart';

class Helppage extends StatefulWidget {
  final String docId;
  const Helppage({super.key,required this.docId});

  @override
  State<Helppage> createState() => _HelppageState();
}

class _HelppageState extends State<Helppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              builder: (context) => ManagePage(docId: widget.docId,)));
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 80.0),
                  Text(
                    "Help  &  Support",
                    style: TextStyle(
                        color: MyMateThemes.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  'Hi, Name',
                  style: TextStyle(
                      fontSize: 20,
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(children: [
              SizedBox(width: 50),
              Text(
                'How can we help you ? ',
                style: TextStyle(
                  fontSize: 14,
                  color: MyMateThemes.primaryColor,
                ),
              ),
            ]),
            SizedBox(height: 15),
            Center(
              child: Container(
                height: 37,
                width: 336,
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(59.0),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
                height: 190,
                width: 340,
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(children: [
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Text(
                      'Self Service',
                      style: TextStyle(
                        fontSize: 12,
                        color: MyMateThemes.textColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2230.svg'),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 100,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2231.svg'),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 180,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2232.svg'),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 260,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2233.svg'),
                    ),
                  ),
                  Positioned(
                    top: 118,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2234.svg'),
                    ),
                  ),
                  Positioned(
                    top: 118,
                    left: 100,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2235.svg'),
                    ),
                  ),
                  Positioned(
                    top: 118,
                    left: 180,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/Group 2236.svg'),
                    ),
                  ),
                  Positioned(
                    top: 118,
                    left: 260,
                    child: GestureDetector(
                      onTap: () {},
                      child:
                          SvgPicture.asset('assets/images/Rectangle 2330.svg'),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
                height: 200,
                width: 340,
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Text(
                        'Self  Service',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 14,
                          color: MyMateThemes.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleHelpPage(docId: widget.docId,)));
                          },
                          child: Container(
                            height: 30,
                            width: 330,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: MyMateThemes
                                      .textColor, // You can change the color as needed
                                  width:
                                      0.2, // You can change the width as needed
                                ),
                              ),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 200,
                                    // alignment: Alignment.bottomRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'How do I boost my Profile ?',
                                              style: TextStyle(
                                                color: MyMateThemes.textColor,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  SvgPicture.asset(
                                      'assets/images/chevron-right.svg')
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleHelpPage(docId: widget.docId,)));
                          },
                          child: Container(
                            height: 30,
                            width: 330,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: MyMateThemes
                                      .textColor, // You can change the color as needed
                                  width:
                                      0.2, // You can change the width as needed
                                ),
                              ),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 200,
                                    // alignment: Alignment.bottomRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'How do I boost my Profile ?',
                                              style: TextStyle(
                                                color: MyMateThemes.textColor,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  SvgPicture.asset(
                                      'assets/images/chevron-right.svg')
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleHelpPage(docId: widget.docId,)));
                          },
                          child: Container(
                            height: 30,
                            width: 330,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: MyMateThemes
                                      .textColor, // You can change the color as needed
                                  width:
                                      0.2, // You can change the width as needed
                                ),
                              ),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 200,
                                    // alignment: Alignment.bottomRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'How do I boost my Profile ?',
                                              style: TextStyle(
                                                color: MyMateThemes.textColor,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  SvgPicture.asset(
                                      'assets/images/chevron-right.svg')
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleHelpPage(docId: widget.docId,)));
                          },
                          child: Container(
                            height: 30,
                            width: 330,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: MyMateThemes
                                      .textColor, // You can change the color as needed
                                  width:
                                      0.2, // You can change the width as needed
                                ),
                              ),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 200,
                                    // alignment: Alignment.bottomRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'How do I boost my Profile ?',
                                              style: TextStyle(
                                                color: MyMateThemes.textColor,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  SvgPicture.asset(
                                      'assets/images/chevron-right.svg')
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleHelpPage(docId: widget.docId,)));
                          },
                          child: Container(
                            height: 30,
                            width: 330,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: MyMateThemes
                                      .textColor, // You can change the color as needed
                                  width:
                                      0.2, // You can change the width as needed
                                ),
                              ),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 200,
                                    // alignment: Alignment.bottomRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 5),
                                            Text(
                                              'How do I boost my Profile ?',
                                              style: TextStyle(
                                                color: MyMateThemes.textColor,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  SvgPicture.asset(
                                      'assets/images/chevron-right.svg')
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: () {
                  print('need help');
                },
                child: Container(
                  height: 125,
                  width: 340,
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          'Still Need Help?',
                          style: TextStyle(
                              fontSize: 16,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        SvgPicture.asset('assets/images/headphone.svg'),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          // alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        3.0), // Add bottom padding for spacing
                                child: Row(
                                  children: [
                                    Text(
                                      'Chat With US',
                                      style: TextStyle(
                                        color: MyMateThemes.textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 1),
                                    Text(
                                      'Our Virtual Assistant 24/7',
                                      style: TextStyle(
                                        color: MyMateThemes.textColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ), // Add bottom padding for spacing
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 2),
                                  Text(
                                    'Live Chat : 9 AM to 6 PM [Mon-Sun]',
                                    style: TextStyle(
                                      color: MyMateThemes.textColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 55),
                        SvgPicture.asset('assets/images/chevron-right.svg')
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
