import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'BadgeWidget.dart';
import 'Profiles/CompleteProfile.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showHello = true;
  int _selectedIndex = 0;

  int badgeValue1 = 12;
  int badgeValue2 = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showHello = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
        title: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: showHello ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 5000),
                    child: const Column(children: [
                      Row(
                        children: [
                          Text(
                            'Hello ,',
                            style: TextStyle(
                              color: MyMateThemes.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Your Name',
                            style: TextStyle(
                              color: MyMateThemes.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(width: 10),
                  SizedBox(width: 70),
                  BadgeWidget(
                      assetPath: 'assets/images/Group 2157.svg',
                      badgeValue: badgeValue1),
                  SizedBox(width: 25),
                  BadgeWidget(
                      assetPath: 'assets/images/Group 2153.svg',
                      badgeValue: badgeValue2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          _buildHeaderText('Congratulations'),
          _buildSubHeaderText("You're successfully registered"),
          Stack(
            children: [
              SvgPicture.asset('assets/images/Frame.svg',
                  width: 300, height: 220),
              Positioned(
                  top: 69,
                  right: 98,
                  child: Text(
                    '137',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  )),
              Positioned(
                  top: 118,
                  right: 69,
                  child: Text(
                    'Matches Found',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
          _buildHeaderText('View Matches'),
          SizedBox(height: 27),
          _buildFreePremiumRow(),
          SizedBox(height: 7),
          _buildImageContainers(),
          SizedBox(height: 14),
          _buildFooterRow(),
          SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSubHeaderText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: MyMateThemes.textColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildSvgImage(String assetPath, {double? width, double? height}) {
    return Center(
      child: SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
      ),
    );
  }

  Widget _buildFreePremiumRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Free',
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: MyMateThemes.nomalFontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        _buildPremiumLabel(),
      ],
    );
  }

  Widget _buildPremiumLabel() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/images/Layer 1.svg',
            width: 18.29,
            height: 18.29,
          ),
          SizedBox(width: 4),
          Text(
            'Premium',
            style: TextStyle(
              color: MyMateThemes.primaryColor,
              fontSize: MyMateThemes.nomalFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 164,
          height: 182,
          color: MyMateThemes.containerColor,
          alignment: Alignment.bottomLeft,
        ),
        Container(
          width: 164,
          height: 182,
          color: MyMateThemes.secondaryColor,
          alignment: Alignment.bottomRight,
        ),
      ],
    );
  }

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 22),
        SizedBox(
          height: 50, //height of button
          width: 165, //width of button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfilePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.containerColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              // padding: EdgeInsets.all(10)
            ),
            child: Text(
              'Complete Profile ',
              style: TextStyle(color: MyMateThemes.primaryColor),
            ),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50, //height of button
          width: 164, //width of button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfilePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            child: Text('Subscribe', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: 164.0,
      height: 56.0,
      child: OutlinedButton(
        onPressed: () {
          print('Button pressed');
        },
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        ),
        child: Text(
          'Get Started ',
          style: TextStyle(
            color: Colors.white,
            fontSize: MyMateThemes.buttonFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
