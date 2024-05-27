import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'bottom_navigation_bar.dart';

class OtherProfilePage extends StatefulWidget {
  const OtherProfilePage({Key? key}) : super(key: key);

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  int _selectedIndex = 0;
  int _selectedButtonIndex = 0; // Track selected outline button index
  ScrollController _scrollController = ScrollController();
  bool isSecondContainerVisible = false;
  bool isThirdContainerVisible = false;
  bool isFourthContainerVisible = false;

  bool isButtonSelected(int index) {
    return _selectedButtonIndex == index;
  }

  @override
  void initState() {
    super.initState();
    // Attach listener to scroll controller for position changes
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  // Scroll listener function to update selected button index
  void _scrollListener() {
    double containerHeight = 500.0; // Height of each container
    int newIndex = (_scrollController.offset / containerHeight).floor();
    if (newIndex != _selectedButtonIndex) {
      setState(() {
        _selectedButtonIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
        title: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle back button press
                    },
                    child: SvgPicture.asset(
                      'assets/images/chevron-left.svg',
                    ),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    '@user240676',
                    style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SvgPicture.asset(
                      'assets/images/Group 2073 (1).svg',
                      // width: 230,
                      // height: 195,
                      //color: MyMateThemes.primaryGreen,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Full Name',
                      style: TextStyle(
                        color: MyMateThemes.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Special Mention (Optional)',
                      style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  'assets/images/Group 2145.svg',
                                  //color: MyMateThemes
                                  //  .primaryGreen, // Use the desired color for the icon
                                ),
                              ),
                              SizedBox(height: 5),
                              const Text(
                                '27 Years',
                                style: TextStyle(
                                  color: MyMateThemes
                                      .textColor, // Use your desired text color
                                  fontSize: 12, // Adjust font size as needed
                                  fontWeight: FontWeight
                                      .normal, // Adjust font weight as needed
                                ),
                              ),
                              const Text(
                                '12 Dec 1997',
                                style: TextStyle(
                                  color: MyMateThemes
                                      .primaryColor, // Use your desired text color
                                  fontSize: 10, // Adjust font size as needed
                                  fontWeight: FontWeight
                                      .normal, // Adjust font weight as needed
                                ),
                              ),
                            ],
                          ),
                          foregroundDecoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: MyMateThemes.secondaryColor,
                                      width: 3))),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: VerticalDivider(
                            width: 40,
                            thickness: 2,
                            indent: 40,
                            endIndent: 100,
                            color: MyMateThemes.secondaryColor,
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  'assets/images/Group 2146.svg',
                                  //color: MyMateThemes
                                  //  .primaryGreen, // Use the desired color for the icon
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Teacher',
                                style: TextStyle(
                                  color: MyMateThemes
                                      .textColor, // Use your desired text color
                                  fontSize: 12, // Adjust font size as needed
                                  fontWeight: FontWeight
                                      .normal, // Adjust font weight as needed
                                ),
                              ),
                              Text(
                                'Mannar - SL',
                                style: TextStyle(
                                  color: MyMateThemes
                                      .primaryColor, // Use your desired text color
                                  fontSize: 10, // Adjust font size as needed
                                  fontWeight: FontWeight
                                      .normal, // Adjust font weight as needed
                                ),
                              ),
                            ],
                          ),
                          foregroundDecoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: MyMateThemes.secondaryColor,
                                      width: 5))),
                        ),
                        const VerticalDivider(
                          width: 60,
                          thickness: 2,
                          indent: 10,
                          endIndent: 100,
                          color: Color(0x00D9D9D9),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  'assets/images/Group 2147.svg',
                                  //color: MyMateThemes
                                  //  .primaryGreen, // Use the desired color for the icon
                                ),
                              ),
                              SizedBox(height: 5),
                              const Text(
                                'Jaffna',
                                style: TextStyle(
                                  color: MyMateThemes
                                      .textColor, // Use your desired text color
                                  fontSize: 12, // Adjust font size as needed
                                  fontWeight: FontWeight
                                      .normal, // Adjust font weight as needed
                                ),
                              ),
                              const Text(
                                'Sri Lanka',
                                style: TextStyle(
                                  color: MyMateThemes
                                      .primaryColor, // Use your desired text color
                                  fontSize: 10, // Adjust font size as needed
                                  fontWeight: FontWeight
                                      .normal, // Adjust font weight as needed
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 340,
                          height: 100,
                          color: MyMateThemes.secondaryColor,
                          child: const Center(
                            child: Text(
                              'Bio (192 letters)',
                              textAlign: TextAlign
                                  .center, // Align the text at the center horizontally
                              style: TextStyle(
                                color: MyMateThemes
                                    .textColor, // Adjust the text color as needed
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 340,
                        //   height: 162,
                        //   color: MyMateThemes.secondaryGreen,
                        // ),
                      ],
                    ),

                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isSecondContainerVisible,
                          child: SizedBox(height: 15),
                        ),
                        Visibility(
                          visible: isSecondContainerVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 340,
                                height: 500,
                                color: MyMateThemes.secondaryColor,
                                child: Center(
                                  child: Text(
                                    'Container 2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: MyMateThemes.textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isThirdContainerVisible,
                          child: SizedBox(height: 15),
                        ),
                        Visibility(
                          visible: isThirdContainerVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 340,
                                height: 500,
                                color: MyMateThemes.secondaryColor,
                                child: Center(
                                  child: Text(
                                    'Container 3',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: MyMateThemes.textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isFourthContainerVisible,
                          child: SizedBox(height: 15),
                        ),
                        Visibility(
                          visible: isFourthContainerVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 340,
                                height: 500,
                                color: MyMateThemes.secondaryColor,
                                child: Center(
                                  child: Text(
                                    'Container 4',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: MyMateThemes.textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 0;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(
                        1); // Scroll to the starting position of Container 2
                  },
                  style: ButtonStyle(
                    // Use the isButtonSelected function to determine button color
                    foregroundColor: MaterialStateProperty.all(
                      isButtonSelected(0)
                          ? MyMateThemes.secondaryColor
                          : MyMateThemes.containerColor,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonSelected(0)
                          ? MyMateThemes.secondaryColor
                          : MyMateThemes.containerColor,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    side: MaterialStateProperty.all(BorderSide.none),
                    minimumSize: MaterialStateProperty.all(Size(103.31, 40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2148.svg',
                        // Replace this with your SVG icon path
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Astrology',
                        style: TextStyle(
                          color: MyMateThemes.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 1;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(2);
                  },
                  style: ButtonStyle(
                    // Use the isButtonSelected function to determine button color
                    foregroundColor: MaterialStateProperty.all(
                      isButtonSelected(1)
                          ? MyMateThemes.secondaryColor
                          : MyMateThemes.containerColor,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonSelected(1)
                          ? MyMateThemes.secondaryColor
                          : MyMateThemes.containerColor,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    side: MaterialStateProperty.all(BorderSide.none),
                    minimumSize: MaterialStateProperty.all(Size(103.31, 40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2149.svg',
                        // Replace this with your SVG icon path
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Family',
                        style: TextStyle(
                          color: MyMateThemes.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 2;
                      isSecondContainerVisible = true;
                      isThirdContainerVisible = true;
                      isFourthContainerVisible = true;
                    });
                    _scrollToContainer(3);
                  },
                  style: ButtonStyle(
                    // Use the isButtonSelected function to determine button color
                    foregroundColor: MaterialStateProperty.all(
                      isButtonSelected(2)
                          ? MyMateThemes.secondaryColor
                          : MyMateThemes.containerColor,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonSelected(2)
                          ? MyMateThemes.secondaryColor
                          : MyMateThemes.containerColor,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    side: MaterialStateProperty.all(BorderSide.none),
                    minimumSize: MaterialStateProperty.all(Size(103.31, 40)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 2150.svg',
                        // Replace this with your SVG icon path
                        width: 18.29, // Adjust the width as needed
                        height: 18.29, // Adjust the height as needed
                        // color: MyMateThemes
                        //     .primaryGreen, // Use the desired color for the icon
                      ),
                      SizedBox(width: 4),
                      Text(
                        'About me',
                        style: TextStyle(
                          color: MyMateThemes.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 132.0,
            height: 39.0,
            child: OutlinedButton(
              onPressed: () {
                // Handle button press action
                print('Button pressed');
              },
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                backgroundColor:
                    MaterialStatePropertyAll(MyMateThemes.primaryColor),
                shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                // alignment: Alignment(231, 689)
              ),
              child: Text(
                'Get Started ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation here based on the index
        },
      ),
    );
  }

  void _scrollToContainer(int index) {
    double containerHeight =
        500.0; // Assuming all containers have the same height
    double targetPosition = index * containerHeight - containerHeight / 2;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
