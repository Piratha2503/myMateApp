import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'BadgeWidget.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';
import 'CompleteProfileScreen/CompleteProfileMain.dart';
import 'SubscribedhomeScreen/SubscribedHomeScreenWidgets.dart';

class HomeScreenBeforeSubscibe extends StatefulWidget {
  final int selectedBottomBarIconIndex;
  final String docId;

  const HomeScreenBeforeSubscibe(this.selectedBottomBarIconIndex, {required this.docId,super.key});

  @override
  State<HomeScreenBeforeSubscibe> createState() => _HomeScreenBeforeSubscibeState();
}

class _HomeScreenBeforeSubscibeState extends State<HomeScreenBeforeSubscibe>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showHello = true;
  int _selectedIndex = 0;


  int badgeValue1 = 2;
  int badgeValue2 = 10;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller.forward();
    print(widget.docId);
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
    return  LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;


          return Scaffold(
          backgroundColor: MyMateThemes.backgroundColor,
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: widget.selectedBottomBarIconIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }, docId: widget.docId,
          ),
        );
      }
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
        automaticallyImplyLeading: false,

        title: SafeArea(
          child:  LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxWidth;
                return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: height*0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: showHello ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 5000),
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                'Hello ,',
                                style: TextStyle(
                                  color: MyMateThemes.primaryColor,
                                  fontSize: width*0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                               SizedBox(width: width*0.01),
                               Text(
                                'Your Name',
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontSize: width*0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),

                      SizedBox(width: width*0.3),
                      BadgeWidget(
                          assetPath: 'assets/images/Group 2157.svg',
                          badgeValue: badgeValue1),
                      SizedBox(width: width*0.035),
                      BadgeWidget(
                          assetPath: 'assets/images/Group 2153.svg',
                          badgeValue: badgeValue2),
                    ],
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.01),
              _buildHeaderText('Congratulations'),
              _buildSubHeaderText("You're successfully registered"),

              // Use a SizedBox with a defined height to maintain proportions
              SizedBox(
                height: height * 0.3, // Adjust height for large screens
                width: width * 1.3, // Ensures better width scaling
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    print('Height: ${constraints.maxHeight*0.9}, Width: ${constraints.maxWidth}'); // Debugging
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/Frame.svg',
                                height: constraints.maxHeight * 1.3,
                                width: constraints.maxWidth * 1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.3, // Adjust top position
                              left: 0,
                              right: 0,
                              child: Center(
                                child: CommonTextStyleForPage(
                                  '137',
                                  Colors.white,
                                  FontWeight.w700,
                                  constraints.maxWidth * 0.08, // Adjust font size
                                ),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.56, // Adjust top position
                              left: 0,
                              right: 0,
                              child: Center(
                                child: CommonTextStyleForPage(
                                  'Matches Found',
                                  Colors.white,
                                  FontWeight.w500,
                                  constraints.maxWidth * 0.043, // Adjust font size
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: height * 0.02),
              _buildHeaderText('View Matches'),
              SizedBox(height: height * 0.015),
              _buildFreePremiumRow(),
              SizedBox(height: height * 0.01),
              _buildImageContainers(),
              SizedBox(height: height * 0.02),
              _buildFooterRow(),
              SizedBox(height: height * 0.01),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderText(String text) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;


          return Center(
          child: Text(
            text,
            style: TextStyle(
              color: MyMateThemes.primaryColor,
              fontSize: width*0.042,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }
    );
  }

  Widget _buildSubHeaderText(String text) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;

          return Center(
          child: Text(
            text,
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: width*0.04,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      }
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
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;

          return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Free',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: MyMateThemes.nomalFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildPremiumLabel(),
          ],
        );
      }
    );
  }

  Widget _buildPremiumLabel() {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;


          return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/images/Layer 1.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 4),
              Text(
                'Premium',
                style: TextStyle(
                  color: MyMateThemes.primaryColor,
                  fontSize: MyMateThemes.nomalFontSize,
                  fontWeight: FontWeight.w500,

                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildImageContainers() {
    return  LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;

          return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width*0.43,
              height: height*0.45,
              color: MyMateThemes.containerColor,
              alignment: Alignment.bottomLeft,
            ),
            Container(
              width: width*0.43,
              height:  height*0.45,
              color: MyMateThemes.secondaryColor,
              alignment: Alignment.bottomRight,
            ),
          ],
        );
      }
    );
  }

  Widget _buildFooterRow() {
    return  LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxWidth;

          return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: width*0.05),
            SizedBox(
              height: height*0.13, //height of button
              width: width*0.43, //width of button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompleteProfilePage(docId: widget.docId)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyMateThemes.containerColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width*0.01),
                  ),
                  // padding: EdgeInsets.all(10)
                ),
                child: Text(
                  'Complete Profile ',
                  style: TextStyle(color: MyMateThemes.primaryColor),
                ),
              ),
            ),
            SizedBox(width: width*0.045),
            SizedBox(
              height: height*0.13, //height of button
              width: width*0.43, //width of button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompleteProfilePage(docId: widget.docId,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyMateThemes.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width*0.01),
                  ),
                ),
                child: Text('Subscribe', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      }
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
