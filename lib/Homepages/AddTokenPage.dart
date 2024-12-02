import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../ManagePages/ManagePage.dart';

class AddTokenPage extends StatefulWidget {
  const AddTokenPage({super.key});

  @override
  State<AddTokenPage> createState() => _AddTokenPageState();
}

class _AddTokenPageState extends State<AddTokenPage> {
  final List<Widget> imageSliders = [
    Container(
      width: 217,
      height: 422,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MyMateThemes.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 12,
            child: SvgPicture.asset('assets/images/purple.svg'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 28),
              Text(
                'Basic',
                style: TextStyle(
                    fontSize: 18,
                    color: MyMateThemes.primaryColor,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 36),
                  Text(
                    '\$10',
                    style: TextStyle(
                        fontSize: 18,
                        color: MyMateThemes.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 3),
                  SvgPicture.asset('assets/images/tick.svg'),
                  SizedBox(width: 10),
                  Text(
                    'Free priority match suggestions',
                    style: TextStyle(
                        fontSize: 10, color: MyMateThemes.primaryColor),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),

              SizedBox(height: 7),
              Text(
                ' for 1 Day',
                style:
                TextStyle(fontSize: 10, color: MyMateThemes.primaryColor),
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 2),
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
              SizedBox(height: 10),
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
              SizedBox(height: 50),
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
    ),
    Container(
      width: 217,
      height: 422,
      decoration: BoxDecoration(
        color: MyMateThemes.primaryColor,
        border: Border.all(color: MyMateThemes.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 12,
            child: SvgPicture.asset('assets/images/whi.svg'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 28),
              Text(
                'Standard',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+30',
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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 36),
                  Text(
                    '\$15',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/white.svg'),
                  SizedBox(width: 10),
                  Text(
                    'Free priority match suggestions',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                ' for 3 Days',
                style: TextStyle(fontSize: 10, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/white.svg'),
                  SizedBox(width: 10),
                  Text(
                    'Free priority searches for 3 Days',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 21),
                  SvgPicture.asset('assets/images/white.svg'),
                  SizedBox(width: 10),
                  Text(
                    'Free priority explore for 3 Days',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  print('Purchase Package 2');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  foregroundColor: MyMateThemes.primaryColor, // Text color
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
    ),
    Container(
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
        width: 217,
        height: 422,
        decoration: BoxDecoration(
          color: MyMateThemes.premiumColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 12,
              child: SvgPicture.asset('assets/images/mixed.svg'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/tick.svg'),
                    SizedBox(width: 10),
                    Text(
                      'Premium',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    SizedBox(width: 3),
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 36),
                    Text(
                      '\$20',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/white.svg'),
                    SizedBox(width: 10),
                    Text(
                      'Free priority match suggestions',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  ' for 7 Days',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/white.svg'),
                    SizedBox(width: 10),
                    Text(
                      'Free priority searches for 7 Days',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 22),
                    SvgPicture.asset('assets/images/white.svg'),
                    SizedBox(width: 10),
                    Text(
                      'Free priority explore for 7 Days',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 40),
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
                )
              ],
            ),
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
      Center(
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
                              builder: (context) => ManagePage()));
                    },
                    child: SvgPicture.asset('assets/images/chevron-left.svg'),
                  ),
                  SizedBox(width: 50.0),
                  Text(
                    "Choose you package here ",
                    style: TextStyle(
                        color: MyMateThemes.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Pricing Plan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: MyMateThemes.primaryColor,
                  letterSpacing: 1.2),
            ),
            SizedBox(height: 5),
            Text(
              'You Need to spend tokens to access ',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: MyMateThemes.textColor,
                  letterSpacing: 0.5),
            ),
            Text(
              'Following features',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: MyMateThemes.textColor,
                  letterSpacing: 0.5),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 120),
                SvgPicture.asset('assets/images/fire.svg'),
                SizedBox(width: 5),
                Text(
                  'x 1',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyMateThemes.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Send/Accept Request',
                  style: TextStyle(
                      fontSize: 12,
                      color: MyMateThemes.textColor.withOpacity(0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 120),
                SvgPicture.asset('assets/images/fire.svg'),
                SizedBox(width: 5),
                Text(
                  'x 2',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyMateThemes.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Check Accurate Match',
                  style: TextStyle(
                      fontSize: 12,
                      color: MyMateThemes.textColor.withOpacity(0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 120),
                SvgPicture.asset('assets/images/fire.svg'),
                SizedBox(width: 5),
                Text(
                  'x 3',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyMateThemes.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Boost Profile',
                  style: TextStyle(
                      fontSize: 12,
                      color: MyMateThemes.textColor.withOpacity(0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 120),
                SvgPicture.asset('assets/images/fire.svg'),
                SizedBox(width: 5),
                Text(
                  'x 5',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyMateThemes.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Super Boost Profile',
                  style: TextStyle(
                      fontSize: 12,
                      color: MyMateThemes.textColor.withOpacity(0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  height: 430.0,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.6,
                ),
              ),
            ),

          ],
        ),
      ),
    ));
  }
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
