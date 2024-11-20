import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'EditPage.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  late final int badgeValue = 6;

  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final FocusNode _cardFocusNode = FocusNode();
  final FocusNode _cvvFocusNode = FocusNode();


  TextEditingController? _activeController; // Track the active text field controller
  FocusNode? _activeFocusNode; // Track the active focus node

  DateTime? selectedDate;
  String? selectedMonth;
  String? selectedYear;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> years = List.generate(20, (index) => (2024 + index).toString());


  Widget _numberPadButton(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_activeController != null) {
            if (value == 'C') {
              _activeController!.clear();
            } else if (value == '<') {
              if (_activeController!.text.isNotEmpty) {
                _activeController!.text = _activeController!.text.substring(
                  0,
                  _activeController!.text.length - 1,
                );
              }
            } else {
              _activeController!.text += value;
              _activeFocusNode?.requestFocus(); // Ensure cursor stays active
            }
          }
        });
      },
      child: Container(
        width: 85, // Adjust the size of each button
        height: 43,
        decoration: BoxDecoration(
          color: MyMateThemes.premiumColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFAC359C),
                        Color(0xFF7D67EE),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15), // Border radius for outer container
                  ),
                  padding: EdgeInsets.all(3), // Padding to create the border effect
                  child: Container(
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      color: MyMateThemes.premiumColor, // Inner container color
                      borderRadius: BorderRadius.circular(15), // Slightly smaller radius
                      boxShadow: [
                        BoxShadow(
                          color:Color(0xFF473B88),
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            SvgPicture.asset('assets/images/white.svg'),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              'Premium',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              '\$20',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(width: 110),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/mixed.svg'),
                                GradientText(
                                  text: '+120',
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFAC359C),
                                      Color(0xFF7D67EE),
                                    ],
                                  ),
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 3),
                                GradientText(
                                  text:   'Tokens',
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFAC359C),
                                      Color(0xFF7D67EE),
                                    ],
                                  ),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 50),
                SvgPicture.asset('assets/images/Frame_1.svg'),
                SizedBox(width: 20),
                SvgPicture.asset('assets/images/Frame_2.svg'),
                SizedBox(width: 20),
                SvgPicture.asset('assets/images/Frame_3.svg'),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  'Debit / Credit Card Number',
                  style: TextStyle(
                      fontSize: 20,
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 297,
                  height: 44,
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextField(
                    controller: _cardController,
                    showCursor: true,
                    readOnly: true, // Prevent default keyboard
                    onTap: () {
                      setState(() {
                        _activeController = _cardController; // Set active controller
                        _activeFocusNode = _cardFocusNode;
                        _activeFocusNode?.requestFocus(); // Request focus manually
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 45),
                Text(
                  'Date ',
                  style: TextStyle(
                      fontSize: 20,
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 175),
                Text(
                  'CVV ',
                  style: TextStyle(
                      fontSize: 20,
                      color: MyMateThemes.textColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 15),
        // Date and CVV Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 49),
                SizedBox(
                  width:100,
                  height: 44, // Reduced height
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 5), // Adjust padding
                      fillColor: MyMateThemes.secondaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: selectedMonth,
                    items: months
                        .map((month) => DropdownMenuItem(
                      value: month,
                      child: Text(
                        month,
                        style: TextStyle(fontSize: 12,color: MyMateThemes.textColor), // Smaller font size
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value;
                      });
                    },
                    hint: Text(
                      'Month',
                      style: TextStyle(fontSize: 12,color: MyMateThemes.textColor.withOpacity(0.7)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 70,
                  height: 44, // Reduced height
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 7, vertical: 5), // Adjust padding
                      fillColor: MyMateThemes.secondaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: selectedYear,
                    items: years
                        .map((year) => DropdownMenuItem(
                      value: year,
                      child: Text(
                        year,
                        style: TextStyle(fontSize: 12,color: MyMateThemes.textColor), // Smaller font size
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                    hint: Text(
                      'Year',
                      style: TextStyle(fontSize: 12,color: MyMateThemes.textColor.withOpacity(0.7)),
                    ),
                  ),
                ),
                SizedBox(width: 33),
                Container(
                  width: 80,
                  height: 44, // Reduced height
                  decoration: BoxDecoration(
                    color: MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextField(
                    controller: _cvvController,
                    showCursor: true,
                    readOnly: true, // Prevent default keyboard
                    onTap: () {
                      setState(() {
                        _activeController = _cvvController; // Set active controller
                        _activeFocusNode = _cvvFocusNode;
                        _activeFocusNode?.requestFocus(); // Request focus manually
                      });
                    },
                    style: TextStyle(fontSize: 12,color: MyMateThemes.textColor), // Smaller font size
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Adjust padding
                      border: InputBorder.none,

                    ),

                  ),
                ),
              ],
            ),

            SizedBox(height: 25),
            ElevatedButton(

              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EditPage()),
                // );
              },
              style: ElevatedButton.styleFrom(

                backgroundColor: MyMateThemes.premiumColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text(
                'Conform Payment',
                style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16),
              ),
            ),
            SizedBox(height:15 ),
            if (_activeController != null)
              Container(
              width: 340, // Fixed width for the number pad
              height: 225,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: MyMateThemes.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // First row of the number pad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _numberPadButton('1'),
                      _numberPadButton('2'),
                      _numberPadButton('3'),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Second row of the number pad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _numberPadButton('4'),
                      _numberPadButton('5'),
                      _numberPadButton('6'),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Third row of the number pad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _numberPadButton('7'),
                      _numberPadButton('8'),
                      _numberPadButton('9'),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Fourth row of the number pad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _numberPadButton('C'), // Clear button
                      _numberPadButton('0'),
                      _numberPadButton('<'), // Backspace button
                    ],
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //   onPressed: (){}, // Save and navigate to the next page
            //   style: CommonButtonStyle.commonButtonStyle(
            //
            //   ),
            //   child: Text(
            //     'Conform Payment',
            //     style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16),
            //   ),
            // ),
        ],
      ),
      ),
    );

  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  const GradientText({super.key,
    required this.text,
    required this.gradient,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
