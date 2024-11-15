import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import 'Profiles/EditPage.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final int _selectedIndex = 0;
  late final int badgeValue = 6;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _anotherYearController = TextEditingController();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 80),
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
                    borderRadius:
                        BorderRadius.circular(15), // slightly larger radius
                  ),
                  padding: EdgeInsets.all(1),
                  child: Container(
                    height: 113,
                    width: 327,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: MyMateThemes.premiumColor,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                                  letterSpacing: 1.0),
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
                                // GradientText(
                                //   'Tokens',
                                //   gradient: LinearGradient(
                                //     colors: [
                                //       Color(0xFFAC359C),
                                //       Color(0xFF7D67EE),
                                //     ],
                                //   ),
                                //   style: TextStyle(fontSize: 20),
                                //   text: '',
                                // ),
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
            SizedBox(height: 60),
            Row(
              children: [
                SizedBox(width: 50),
                SvgPicture.asset('assets/images/Frame_1.svg'),
                SizedBox(width: 20),
                SvgPicture.asset('assets/images/Frame_2.svg'),
                SizedBox(width: 20),
                SvgPicture.asset('assets/images/Frame_2.svg'),
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
                    controller: _monthController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      setState(() {
                        // Trigger a rebuild to move the TextField up
                      });
                    },
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: 101,
            //       height: 44,
            //       decoration: BoxDecoration(
            //         color: MyMateThemes.secondaryColor,
            //         borderRadius: BorderRadius.circular(5.0),
            //       ),
            //       child: ScrollWheelMonthPicker(
            //         scrollViewOptions: ScrollWheelOptions(
            //           loop: false,
            //         ),
            //         initialDateTime: DateTime.now(),
            //         onChanged: (dateTime) {
            //           setState(() {
            //             selectedDate = dateTime;
            //           });
            //         },
            //         maxDate: DateTime(2100),
            //         minDate: DateTime(1900),
            //       ),
            //     ),
            //     SizedBox(width: 15),
            //     Container(
            //       width: 90,
            //       height: 44,
            //       decoration: BoxDecoration(
            //         color: MyMateThemes.secondaryColor,
            //         borderRadius: BorderRadius.circular(5.0),
            //       ),
            //       child: TextField(
            //         controller: _yearController,
            //         decoration: InputDecoration(
            //           hintText: "Year",
            //           border: InputBorder.none,
            //           suffixIcon: IconButton(
            //             icon: Icon(Icons.arrow_drop_down_outlined),
            //             onPressed: () {
            //               print(_yearController.text);
            //               _yearController
            //                   .clear(); // Clear the text field after sending
            //             },
            //           ),
            //         ),
            //         onTap: () {
            //           setState(() {
            //             // Trigger a rebuild to move the TextField up
            //           });
            //         },
            //       ),
            //     ),
            //     SizedBox(width: 15),
            //     Container(
            //       width: 90,
            //       height: 44,
            //       decoration: BoxDecoration(
            //         color: MyMateThemes.secondaryColor,
            //         borderRadius: BorderRadius.circular(5.0),
            //       ),
            //       child: TextField(
            //         controller: _anotherYearController,
            //         decoration: InputDecoration(
            //           hintText: "Year",
            //           border: InputBorder.none,
            //         ),
            //         onTap: () {
            //           setState(() {
            //             // Trigger a rebuild to move the TextField up
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            if (selectedDate != null) SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyMateThemes.premiumColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text(
                'Confirm Payment',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
