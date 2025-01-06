import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';


final List<Widget> packageSliders = [
  Material(

      child: Container(
        width: 295,
        height: 272,
        decoration:
        BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyMateThemes.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              //color:
                color: MyMateThemes.primaryColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),

            )
          ]
        ),

        child: Stack(
          children: [
            Positioned(
              top: 18,
              left: 55,
              child:
              SvgPicture.asset('assets/images/purple.svg'),
            ),
            Positioned(
              top: 16,
              left: 105,
              child:
              Text(
                'Basic',
                style: TextStyle(
                    fontSize: 20,
                    color: MyMateThemes.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              top: 90,
              left: 45,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '\$10',
                    style: TextStyle(
                        fontSize: 18,
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
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 34),
                        Text(
                          '+30',
                          style: TextStyle(
                              fontSize: 30,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tokens',
                          style: TextStyle(
                              fontSize: 24,
                              color: MyMateThemes.primaryColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0),
                        ),
                      ],
                    ),
                    SizedBox(height:55),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 45),
                        SvgPicture.asset('assets/images/tick.svg'),
                        SizedBox(width: 10),
                        Text(
                          'Free priority match suggestions for 1 day',
                          style: TextStyle(
                              fontSize: 10,
                              color: MyMateThemes.primaryColor),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                    SizedBox(height:12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 3),
                        SvgPicture.asset('assets/images/tick.svg'),
                        SizedBox(width: 10),
                        Text(
                          'Free priority searches for 1 Day',
                          style: TextStyle(
                              fontSize: 10, color: MyMateThemes.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/tick.svg'),
                        SizedBox(width: 10),
                        Text(
                          'Free priority explore for 1 Day',
                          style: TextStyle(
                              fontSize: 10, color: MyMateThemes.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                        onPressed: () {
                          print('Purchase Package 1');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          MyMateThemes.primaryColor, // Background color
                          foregroundColor: Colors.white, // Text color
                          minimumSize: Size(100, 30), // Width and height
                          padding: EdgeInsets.symmetric(horizontal: 16), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
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
    ),
  Material(
   // elevation: 40,
    child: Container(
      width: 295,
      height: 272,
      decoration:
      BoxDecoration(
          color: MyMateThemes.primaryColor,
          border: Border.all(color: MyMateThemes.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              //color:
              color: MyMateThemes.primaryColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),

            )
          ]
      ),

      child: Stack(
        children: [
          Positioned(
            top: 18,
            left: 55,
            child:
            SvgPicture.asset('assets/images/whi.svg'),
          ),
          Positioned(
            top: 16,
            left: 105,
            child:
            Text(
                'Standard',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            top: 90,
            left: 45,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '\$15',
                  style: TextStyle(
                      fontSize: 18,
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
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 34),
                      Text(
                        '+60',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Tokens',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                  SizedBox(height:55),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 45),
                      SvgPicture.asset('assets/images/white.svg'),
                      SizedBox(width: 10),
                      Text(
                        'Free priority match suggestions for 3 day',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                  SizedBox(height:12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 3),
                      SvgPicture.asset('assets/images/white.svg'),
                      SizedBox(width: 10),
                      Text(
                        'Free priority searches for 3 Day',
                        style: TextStyle(
                            fontSize: 10, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/white.svg'),
                      SizedBox(width: 10),
                      Text(
                        'Free priority explore for 3 Day',
                        style: TextStyle(
                            fontSize: 10, color:Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                    ElevatedButton(
                        onPressed: () {
                          print('Purchase Package 2');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          MyMateThemes.backgroundColor, // Background color
                          foregroundColor: MyMateThemes.primaryColor, // Text color
                          minimumSize: Size(100, 30), // Width and height
                          padding: EdgeInsets.symmetric(horizontal: 30), // Padding

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
  ),
  Material(
    //elevation: 40,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFAC359C),
              Color(0xFF7D67EE),
            ],
          ),
          borderRadius: BorderRadius.circular(12), // slightly larger radius
            boxShadow: [
              BoxShadow(
                //color:
                color: MyMateThemes.primaryColor,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),

              )
            ]
        ),

        padding: EdgeInsets.all(2), // width of the border
        child: Container(
          width:295,
          height:272,
          decoration: BoxDecoration(
            color: MyMateThemes.premiumColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 18,
                left:50,
                child: SvgPicture.asset('assets/images/mixed.svg'),
              ),
              Positioned(
                //top:29,
                top:29,
                left: 90,
                child:
                SvgPicture.asset('assets/images/tick.svg'),
              ),
              Positioned(
                top: 22,
                left: 115,
                child:
                Text(
                  'Premium',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Positioned(
                top: 90,
                left: 45,
                // top: 100,
                // left: 40,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text(
                      '\$20',
                      style: TextStyle(
                          fontSize: 18,
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
                      SizedBox(height: 17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                                  SizedBox(width: 34),
                                  GradientText(
                                    '+120',
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFAC359C),
                                        Color(0xFF7D67EE),
                                      ],
                                    ),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(width: 10),
                                  GradientText(
                                    'Tokens',
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFAC359C),
                                        Color(0xFF7D67EE),
                                      ],
                                    ),
                                    style: TextStyle(fontSize: 24),
                                  ),

                                ],
                              ),


                              SizedBox(height: 55),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 44),
                                  SvgPicture.asset('assets/images/white.svg'),
                                  SizedBox(width: 10),
                                  Text(
                                    'Free priority match suggestions for 3 day',
                                    style: TextStyle(
                                        fontSize: 10, color:Colors.white),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                              SizedBox(height:12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 3),
                                  SvgPicture.asset('assets/images/white.svg'),
                                  SizedBox(width: 10),
                                  Text(
                                    'Free priority searches for 3 Day',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 1),
                                  SvgPicture.asset('assets/images/white.svg'),
                                  SizedBox(width: 10),
                                  Text(
                                    'Free priority explore for 3 Day',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
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
                                    BorderRadius.circular(30), // Rounded corners
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
                                    height: 30,
                                    width: 100,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                    child: Text(
                                      'Purchase',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 16,
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
    ),
];

final List<Widget> offerSliders = [
  Material(
    elevation: 40,
    child:
    GestureDetector(
      onTap: (){
        print('select first');
      },

      child:  Container(
        width: 301,
        height: 263,

        decoration: BoxDecoration(

          color: Colors.white,
          //border: Border.all(color: MyMateThemes.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/images/offer_1.jpg'), // Your background image
            fit: BoxFit.cover, // Ensures the image covers the container
          ),

        ),
      ),
    ),
  ),
  Material(
    elevation: 20,
    child:
    GestureDetector(
      onTap: (){
        print('select first');
      },

      child:  Container(
        width: 301,
        height: 263,

        decoration: BoxDecoration(

          color: Colors.white,
          //border: Border.all(color: MyMateThemes.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/images/offer_1.jpg'), // Your background image
            fit: BoxFit.cover, // Ensures the image covers the container
          ),

        ),
      ),
    ),
  ),
  Material(
    elevation: 20,
    child:
    GestureDetector(
      onTap: (){
        print('select first');
      },

      child:  Container(
        width: 301,
        height: 263,

        decoration: BoxDecoration(

          color: Colors.white,
          //border: Border.all(color: MyMateThemes.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/images/offer_1.jpg'), // Your background image
            fit: BoxFit.cover, // Ensures the image covers the container
          ),

        ),
      ),
    ),
  ),
  ];

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

