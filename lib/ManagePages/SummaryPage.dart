import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'ManagePage.dart';

class Summarypage extends StatefulWidget {
  const Summarypage({super.key});

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Summary ",
          style: TextStyle(
              color: MyMateThemes.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyMateThemes.primaryColor),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ManagePage()));
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
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
              'Here is your summary',
              style: TextStyle(
                fontSize: 14,
                color: MyMateThemes.primaryColor,
              ),
            ),
          ]),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 152,
                height: 176,
                decoration: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 10,
                        left: 55,
                        child: Text(
                          '187',
                          style: TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      bottom: 30,
                      right: 60,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Interests',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 87,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'received',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 25),
              Container(
                width: 166,
                height: 176,
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 10,
                        left: 90,
                        child: Text(
                          '1K',
                          style: TextStyle(
                              fontSize: 48,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      bottom: 30,
                      right: 72,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Interests',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'sent',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 340,
                height: 177,
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 7,
                        right: 15,
                        child: Text(
                          '217',
                          style: TextStyle(
                              fontSize: 48,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      bottom: 15,
                      left: 20,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Interested',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 166,
                height: 176,
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 5,
                        left: 88,
                        child: Text(
                          '1K',
                          style: TextStyle(
                              fontSize: 48,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      bottom: 30,
                      right: 80,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Matches',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 123,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'sent',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 25),
              Container(
                width: 152,
                height: 176,
                decoration: BoxDecoration(
                  color: MyMateThemes.primaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 10,
                        left: 55,
                        child: Text(
                          '187',
                          style: TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                      bottom: 30,
                      right: 61,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Matches',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 11,
                      right: 85,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'received',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
