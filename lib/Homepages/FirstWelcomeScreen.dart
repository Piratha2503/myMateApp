import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'BadgeWidget.dart';
import 'bottom_navigation_bar.dart';

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

  int badgeValue1 = 1;
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    opacity: showHello ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 5000),
                    child: const Text(
                      'Hello',
                      style: TextStyle(
                        color: MyMateThemes.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
          _buildHeaderText('Congratulations'),
          _buildSubHeaderText("You're successfully registered"),
          _buildSvgImage('assets/images/Group 2073.svg',
              width: 230, height: 195),
          SizedBox(height: 10),
          _buildHeaderText('View Matches'),
          SizedBox(height: 30),
          _buildFreePremiumRow(),
          SizedBox(height: 7),
          _buildImageContainers(),
          SizedBox(height: 15),
          _buildFooterRow(),
          SizedBox(height: 15),
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
          height: 188,
          color: MyMateThemes.containerColor,
          alignment: Alignment.bottomLeft,
        ),
        Container(
          width: 164,
          height: 188,
          color: MyMateThemes.secondaryColor,
          alignment: Alignment.bottomRight,
        ),
      ],
    );
  }

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            print('Link tapped');
          },
          child: Text(
            'Complete Profile',
            style: TextStyle(
              color: MyMateThemes.primaryColor,
              fontSize: MyMateThemes.nomalFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _buildGetStartedButton(),
      ],
    );
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: 164.0,
      height: 58.0,
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
