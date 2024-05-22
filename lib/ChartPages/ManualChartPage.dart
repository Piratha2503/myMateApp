import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:ring_button_group/ring_button_group.dart';

class ManualChartPage extends StatefulWidget {
  const ManualChartPage({Key? key}) : super(key: key);

  @override
  State<ManualChartPage> createState() => _ManualChartPageState();
}

class _ManualChartPageState extends State<ManualChartPage> {
  int _selectedIndex = 0;
  int _selectedButtonIndex = 0;

  bool isButtonSelected(int index) {
    return _selectedButtonIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter Chart Rasi",
                  style: TextStyle(
                      color: MyMateThemes.textGreen,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "to calculate Astrology Chart",
                style: TextStyle(
                    color: MyMateThemes.primaryGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 290,
                height: 184,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 1;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(1)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(1)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "1",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 2;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(2)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(2)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "2",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 3;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(3)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(3)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "3",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 4;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(4)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(4)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "4",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 5;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(5)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(5)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "5",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 6;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(6)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(6)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "6",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 7;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(7)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(7)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "7",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 8;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(8)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(8)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "8",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 9;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(9)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(9)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "9",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 10;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(10)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(10)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "10",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 11;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(11)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(11)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "11",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedButtonIndex = 12;
                              });
                            },
                            style: ButtonStyle(
                              // Use the isButtonSelected function to determine button color
                              foregroundColor: MaterialStateProperty.all(
                                isButtonSelected(12)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                isButtonSelected(12)
                                    ? MyMateThemes.primaryGreen
                                    : MyMateThemes.secondaryGreen,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                              side: MaterialStateProperty.all(BorderSide.none),
                              minimumSize:
                                  MaterialStateProperty.all(Size(56.75, 47.67)),
                            ),
                            child: Text(
                              "12",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Container(
            height: 400,
            width: 300,
            child: SizedBox(
              width: 100, //set a width
              height: 100, //set a height, should be same with width
              child: Stack(
                children: [
                  Positioned(
                    left: -3,
                    bottom: 70,
                    child: GestureDetector(
                      onTap: () {
                        print('Mercury button is pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Mercury.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 30,
                    child: GestureDetector(
                      onTap: () {
                        print('Mars button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Mars.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 70,
                    child: GestureDetector(
                      onTap: () {
                        print('Venus button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Saturn.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    left: -3,
                    bottom: 63,
                    child: GestureDetector(
                      onTap: () {
                        print('Jupiter button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Jupiter.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 30,
                    child: GestureDetector(
                      onTap: () {
                        print('Rahu button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Rahu.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 30,
                    child: GestureDetector(
                      onTap: () {
                        print('Ketu button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Ketu.svg',
                        // height: 100,
                        // width: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 3,
                    bottom: 70,
                    child: GestureDetector(
                      onTap: () {
                        print('Venus button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Venus.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 30,
                    child: GestureDetector(
                      onTap: () {
                        print('Moon button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Moon.svg',
                      ),
                    ),
                  ),
                  // Add more Positioned widgets for other buttons similarly

                  Positioned(
                    bottom: 80,
                    right: 25,
                    child: GestureDetector(
                      onTap: () {
                        print('Center button pressed');
                      },
                      child: SvgPicture.asset(
                        'assets/images/Sun.svg',
                      ),
                    ),
                  ),
                ],
              ),
              //total number of buttons in group

              //   ],
              //   type: RingButtonGroupType
              //       .MULTIPLE_SELECTABLE, // allow multiple select
              //   pressedIndex: const {
              //     1
              //   }, //default selected buttons index, start from 0
              //   shadowEffect: true,
            ),
          ),
        ],
      ),
    );
  }
}
