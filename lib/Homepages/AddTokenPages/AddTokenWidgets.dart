import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';


final List<Widget> packageSliders = [
  Material(

      child: LayoutBuilder(
          builder: (context, constraints) {
            // Read width and height from constraints to use for responsive sizing.
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
          return Expanded(
            child:            Container(
              width: width * 1,
              height: height * 0.5,
              decoration:
              BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: MyMateThemes.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),

              ),

              child: Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.04,
                    //top: constraints.maxHeight * 0.2,
                    left:constraints.maxWidth * 0.08,
                    // top: 18,
                    // left: 55,
                    child:
                    SvgPicture.asset('assets/images/purple.svg'),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.04,
                    left:constraints.maxWidth * 0.4,
                    child:
                    Text(
                      'Basic',
                      style: TextStyle(
                          fontSize: width * 0.08,
                          color: MyMateThemes.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.3,
                    left:constraints.maxWidth * 0.16,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '\$10',
                          style: TextStyle(
                              fontSize: width * 0.08,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.07),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.1),
                              Text(
                                '+30',
                                style: TextStyle(
                                    fontSize:width * 0.12,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.0),
                              ),
                              SizedBox(width: width * 0.03),
                              Text(
                                'Tokens',
                                style: TextStyle(
                                    fontSize: width * 0.1,
                                    color: MyMateThemes.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.0),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.2),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: width * 0.15),
                                  SvgPicture.asset('assets/images/tick.svg'),
                                  SizedBox(width: width * 0.03),
                                  Text(
                                    'Free priority match suggestions for 1 Day',
                                    style: TextStyle(
                                        fontSize: width * 0.035,
                                        color: MyMateThemes.primaryColor),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                              SizedBox(height: height * 0.04),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: width * 0.001),
                                  SvgPicture.asset('assets/images/tick.svg'),
                                  SizedBox(width: width * 0.03),
                                  Text(
                                    'Free priority searches for 1 Day',
                                    style: TextStyle(
                                        fontSize: width * 0.035, color: MyMateThemes.primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.04),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/tick.svg'),
                                  SizedBox(width: width * 0.03),
                                  Text(
                                    'Free priority explore for 1 Day',
                                    style: TextStyle(
                                        fontSize:width * 0.035, color: MyMateThemes.primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: height * 0.04),
                          ElevatedButton(
                            onPressed: () {
                              print('Purchase Package 1');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              MyMateThemes.primaryColor, // Background color
                              foregroundColor: Colors.white, // Text color
                              minimumSize: Size(100, 30), // Width and height
                              padding: EdgeInsets.symmetric(horizontal: 0.05,vertical: height*0.026), // Padding
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(width*0.1), // Rounded corners
                              ),
                            ),
                            child: Text('Purchase'),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

        }
      ),
    ),
  Material(
   // elevation: 40,
    child:LayoutBuilder(
        builder: (context, constraints) {
          // Read width and height from constraints to use for responsive sizing.
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;
        return Expanded(
            child: Container(
              width: width * 1,
              height: height * 0.5,
            decoration:
            BoxDecoration(
                color: MyMateThemes.primaryColor,
                border: Border.all(color: MyMateThemes.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(10),

            ),

            child: Stack(
              children: [
                Positioned(
                  top: constraints.maxHeight * 0.04,
                  left:constraints.maxWidth * 0.08,
                  child:
                  SvgPicture.asset('assets/images/whi.svg'),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.04,
                  left:constraints.maxWidth * 0.4,
                  child:
                  Text(
                      'Standard',
                    style: TextStyle(
                        fontSize:  width * 0.08,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.3,
                  left:constraints.maxWidth * 0.16,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '\$15',
                        style: TextStyle(
                            fontSize: width * 0.08,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.07),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: width * 0.1),
                            Text(
                              '+60',
                              style: TextStyle(
                                  fontSize:width * 0.12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0),
                            ),
                            SizedBox(width: width * 0.03),
                            Text(
                              'Tokens',
                              style: TextStyle(
                                  fontSize: width * 0.1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.2),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: width * 0.15),
                                SvgPicture.asset('assets/images/white.svg'),
                                SizedBox(width: width * 0.03),
                                Text(
                                  'Free priority match suggestions for 3 Days',
                                  style: TextStyle(
                                      fontSize: width * 0.035,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),

                              ],
                            ),
                            SizedBox(height: height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: width * 0.001),
                                SvgPicture.asset('assets/images/white.svg'),
                                SizedBox(width: width * 0.03),
                                Text(
                                  'Free priority searches for 3 Days',
                                  style: TextStyle(
                                      fontSize: width * 0.035, color:Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/white.svg'),
                                SizedBox(width: width * 0.03),
                                Text(
                                  'Free priority explore for 3 Days',
                                  style: TextStyle(
                                      fontSize:width * 0.035, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: height * 0.05),
                          ElevatedButton(
                              onPressed: () {
                                print('Purchase Package 2');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.white, // Background color
                                foregroundColor: MyMateThemes.primaryColor, // Text color
                                minimumSize: Size(100, 30), // Width and height
                                padding: EdgeInsets.symmetric(horizontal: 0,vertical: height*0.026), // Padding
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(width*0.1), // Rounded corners
                                ),
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(30), // Rounded corners
                                // ),
                              ),
                              child: Text('Purchase'),
                            )

                      ],
                    ),
                  ],
                ),
              ],
            ),
                    ),
          );
      }
    ),
  ),
  Material(
    //elevation: 40,
      child: LayoutBuilder(
          builder: (context, constraints) {
            // Read width and height from constraints to use for responsive sizing.
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
          return Expanded(
            child: Container(

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [

                    Color(0xFFAC359C),
                    Color(0xFF7D67EE),
                  ],
                ),
                borderRadius: BorderRadius.circular(12), // slightly larger radius

              ),

              padding: EdgeInsets.all(2), // width of the border
              child: Container(
                width: width * 1,
                height: height * 0.5,
                decoration: BoxDecoration(
                  color: MyMateThemes.premiumColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: constraints.maxHeight * 0.04,
                      left:constraints.maxWidth * 0.08,
                      child: SvgPicture.asset('assets/images/mixed.svg'),
                    ),
                    Positioned(
                      //top:29,
                      top: constraints.maxHeight * 0.06,
                      left:constraints.maxWidth * 0.3,
                      child:
                      SvgPicture.asset('assets/images/Layer 1.svg',height:19,width: 19,),
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.04,
                      left:constraints.maxWidth * 0.4,
                      child:
                      Text(
                        'Premium',
                        style: TextStyle(
                            fontSize: width * 0.08,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.3,
                      left:constraints.maxWidth * 0.16,
                      // top: 100,
                      // left: 40,
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text(
                            '\$20',
                            style: TextStyle(
                                fontSize: width * 0.08,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),),

                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.07),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: width * 0.1),
                                        GradientText(
                                          '+120',
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFAC359C),
                                              Color(0xFF7D67EE),
                                            ],
                                          ),
                                          style: TextStyle(fontSize: width * 0.12),
                                        ),
                                SizedBox(width: width * 0.03),
                                        GradientText(
                                          'Tokens',
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFAC359C),
                                              Color(0xFF7D67EE),
                                            ],
                                          ),
                                          style: TextStyle(fontSize: width * 0.1),
                                        ),

                                      ],
                                    ),
                            SizedBox(height: height * 0.2),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: width * 0.15),
                                    SvgPicture.asset('assets/images/white.svg'),
                                    SizedBox(width: width * 0.03),
                                    Text(
                                      'Free priority match suggestions for 7 Days',
                                      style: TextStyle(
                                          fontSize: width * 0.035,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),

                                  ],
                                ),
                                SizedBox(height: height * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: width * 0.001),
                                    SvgPicture.asset('assets/images/white.svg'),
                                    SizedBox(width: width * 0.03),
                                    Text(
                                      'Free priority searches for 7 Days',
                                      style: TextStyle(
                                          fontSize: width * 0.035, color:Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/white.svg'),
                                    SizedBox(width: width * 0.03),
                                    Text(
                                      'Free priority explore for 7 Days',
                                      style: TextStyle(
                                          fontSize:width * 0.035, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: height * 0.05),
                                    ElevatedButton(
                                      onPressed: () {
                                        print('purchase Package 3');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        // backgroundColor:
                                        //     MyMateThemes.primaryColor, // Background color
                                        // foregroundColor: Colors.white, // Text color
                                        minimumSize: Size(80, 30), // Width and height
                                        padding: EdgeInsets.symmetric(horizontal: 0), // Padding
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(width*0.1), // Rounded corners
                                        ),
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Color(0xFFAC359C), Color(0xFF7D67EE)],
                                          ),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Container(
                                          height: height*0.1,
                                          width: width*0.35,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                          child: Text(
                                            'Purchase',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],


                ),
              ),
            ),
          );
        }
      ),
    ),
];



Widget buildCurrentOffers() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final mediaQuery = MediaQuery.of(context);
      final width = mediaQuery.size.width;
      final height = mediaQuery.size.height;
      return Column(
        children: [
          buildCurrentOffersItem(Color(0xFFE16969)
              ,20), // Example color 1
          SizedBox(height: height * 0.02),
          buildCurrentOffersItem(Color(0xFF55C7A9),30),
          SizedBox(height: height * 0.02),
// Example color 2
          buildCurrentOffersItem(Color(0xFF7C9CD1),40), // Example color 2

        ],
      );
    },
  );
}

Widget buildCurrentOffersItem(Color color, int tokenCount) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final mediaQuery = MediaQuery.of(context);
      final width = mediaQuery.size.width;
      final height = mediaQuery.size.height;

      return Container(
        width: width * 0.86,
        height: height * 0.28,
        decoration: BoxDecoration(
          color: color.withOpacity(0.03),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            /// Main Content
            Column(
              children: [
                SizedBox(height: height * 0.02),

                /// Title Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Text(
                        "Valentine's Week Offer",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: color,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),

                /// Offer List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildOfferRow('Free priority match suggestions for 1 Day'),
                    SizedBox(height: height * 0.01),
                    buildOfferRow('Free priority searches for 1 Day'),
                    SizedBox(height: height * 0.01),
                    buildOfferRow('Free priority explore for 1 Day'),
                  ],
                ),

                SizedBox(height: height * 0.03),

                /// Price & Purchase Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.06),

                    Text(
                      '\$12',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: width * 0.1),
                    ElevatedButton(
                      onPressed: () {
                        print('Purchase offer');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color, // Background color
                        foregroundColor: Colors.white, // Text color
                        minimumSize: Size(100, 40), // Width and height
                        padding: EdgeInsets.symmetric(horizontal: width*0.08,vertical: height*0.007),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width*0.06),
                        ),
                      ),
                      child: Text('Purchase'),
                    ),
                  ],
                ),

                /// Validity Period
                Text(
                  'valid on Feb 7 - Feb 14',
                  style: TextStyle(
                    color: color,
                    fontSize: width * 0.03,
                  ),
                ),
              ],
            ),

            /// SVG Token Banner (Top Right)
            Positioned(
              right: width * 0.02,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/Group badge.svg',
                    color: color,// Your banner SVG
                    width: width * 0.1,
                    height: height*0.09,
                  ),
                  Positioned(
                      top: height * 0.018,
                      right: width * 0.11,
                      child:
                      SvgPicture.asset('assets/images/fire.svg',color: Colors.white,width: width * 0.045,height: height*0.019,)),
                  Positioned(
                    top: height * 0.005,
                    right: width * 0.02,
                    // Adjust to align inside the SVG
                    child: Column(
                      children: [
                        Text(
                          '$tokenCount',
                          style: TextStyle(
                            fontSize: width * 0.065,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              Positioned(
                top: height * 0.045,
                right: width * 0.03,
                child:  Text(
                  'Tokens',
                  style: TextStyle(
                    fontSize: width * 0.025,
                    color: Colors.white,


                  ),
                  textAlign: TextAlign.center,
                ),
              ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// Helper function to create the offer rows
Widget buildOfferRow(String text) {

  return LayoutBuilder(
      builder: (context, constraints) {
      final mediaQuery = MediaQuery.of(context);
      final width = mediaQuery.size.width;
      final height = mediaQuery.size.height;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/white.svg', // Your checkmark icon
              width: width * 0.03,
              color: MyMateThemes.textColor, // Adjust color as needed
            ),
            SizedBox(width: width * 0.02),
            Text(
              text,
              style: TextStyle(
                fontSize: width * 0.025,
                color:MyMateThemes.textColor, // Adjust as per theme
              ),
            ),
          ],
        ),
      );
    }
  );
}


  class GradientText extends StatelessWidget {
    const GradientText(this.text,
        {super.key, required this.gradient, this.style});

    final String text;
    final TextStyle? style;
    final Gradient gradient;

    @override
    Widget build(BuildContext context) {
      return ShaderMask(
        shaderCallback: (bounds) {
          return gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: Text(
          text,
          style: style?.copyWith(color: Colors.white),
        ),
      );
    }
  }

