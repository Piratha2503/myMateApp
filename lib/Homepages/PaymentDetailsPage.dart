import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:flutter/services.dart';


import 'Profiles/EditPage.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {

  DateTime _selectedDate = DateTime.now();

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

  final List<String> years = List.generate(50, (index) => (2024 + index).toString());


  Widget _numberPadButton(String value) {

    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
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
            width: 55, // Adjust the size of each button
            height: 33,
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
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevents UI shrinking when keyboard appears
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  GestureDetector(
          onTap: () {
         //   Navigator.pop(context); // Ensure proper navigation back


          },
          child: SvgPicture.asset(
            'assets/images/chevron-left.svg',
            height: 15,
            width: 10,

          ),
        ),

      ),
      body: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return SingleChildScrollView(
            child: SafeArea(

                    child: Padding(

                      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
                      child: Column(
                        children: [
                          SizedBox(height: height*0.02),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child:Container(
                                    width:width * 0.8,
                                    height:height * 0.17,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFAC359C),
                                          Color(0xFF7D67EE),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(width * 0.05), // Border radius for outer container
                                    ),
                                    padding: EdgeInsets.all(width * 0.01), // Padding to create the border effect
                                    child: Container(
                                      width:width * 0.8,
                                      height:height * 0.15,
                                      decoration: BoxDecoration(
                                        color: MyMateThemes.premiumColor, // Inner container color
                                        borderRadius: BorderRadius.circular(width * 0.04), // Slightly smaller radius
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
                                          SizedBox(height:height*0.01),
                                          Row(
                                            children: [
                                              SizedBox(width: width*0.046),
                                              SvgPicture.asset('assets/images/Layer 1.svg',height:19,width: 19),
                                            ],
                                          ),
                                          SizedBox(height: height*0.005),
                                          Row(
                                            children: [
                                              SizedBox(width:width*0.05),
                                              Text(
                                                'Premium',
                                                style: TextStyle(fontSize:width*0.042, color: Colors.white,fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height*0.018),
                                          Row(
                                            children: [
                                              SizedBox(width:width*0.05),
                                              Text(
                                                '\$20',
                                                style: TextStyle(
                                                  fontSize:width*0.046,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.0,
                                                ),
                                              ),
                                              SizedBox(width:width*0.33),
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
                                                    style: TextStyle(fontSize:width*0.046,fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(width:width*0.01),
                                                  GradientText(
                                                    text:   'Tokens',
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFAC359C),
                                                        Color(0xFF7D67EE),
                                                      ],
                                                    ),
                                                    style: TextStyle(fontSize: width*0.05),
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

                            ],
                          ),
                          SizedBox(height:height*0.06),
                          Row(
                            children: [
                              SizedBox(width:width*0.04),
                              SvgPicture.asset('assets/images/Frame_1.svg'),
                              SizedBox(width:width*0.02),
                              SvgPicture.asset('assets/images/Frame_2.svg'),
                              SizedBox(width: width*0.02),
                              SvgPicture.asset('assets/images/Frame_3.svg'),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Text(
                                'Debit / Credit Card Number',
                                style: TextStyle(
                                    fontSize: width*0.04,
                                    color: MyMateThemes.textColor,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: height*0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                                  Container(
                                width:width * 0.85,
                                height:height * 0.055,

                                decoration: BoxDecoration(

                                  color: MyMateThemes.containerColor,
                                  borderRadius: BorderRadius.circular(width * 0.01),
                                ),
                                child: TextField(
                                  controller: _cardController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(19), // includes 3 spaces for format (16 + 3)
                                    CardNumberInputFormatter(),
                                  ],
                                  showCursor: true,
                                  readOnly: false, // Prevent default keyboard
                                  onTap: () {
                                    setState(() {
                                      _activeController = _cardController; // Set active controller
                                      _activeFocusNode = _cardFocusNode;
                                      _activeFocusNode?.requestFocus(); // Request focus manually
                                    });
                                  },
                                  style: TextStyle(fontSize:width * 0.034,color: MyMateThemes.textColor), // Smaller font size

                                  decoration: InputDecoration(
                                    border: InputBorder.none,

                                    contentPadding: EdgeInsets.symmetric(horizontal:width* 0.02, vertical:height* 0.0235), // Adjust padding
                                  ),

                                ),
                              )

                            ],
                          ),
                          SizedBox(height: height*0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width:width*0.04),
                              Text(
                                'Date ',
                                style: TextStyle(
                                    fontSize: width*0.04,
                                    color: MyMateThemes.textColor,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: width*0.49),
                              Text(
                                'CVV ',
                                style: TextStyle(
                                    fontSize:width*0.04,
                                    color: MyMateThemes.textColor,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height:height*0.01),
                          // Date and CVV Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width:width*0.033),
                              Container(
                                width: width * 0.28,
                                height: height * 0.055,
                                decoration: BoxDecoration(
                                  color: MyMateThemes.containerColor,
                                  borderRadius: BorderRadius.circular(width * 0.01),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: width * 0.02), // controls spacing inside the dropdown
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    value: selectedMonth,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedMonth = value;
                                      });
                                    },
                                    isExpanded: true,

                                    // Main items
                                    items: months.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: MyMateThemes.textColor,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),

                                    // Hint
                                    hint: Text(
                                      'Month',
                                      style: TextStyle(
                                        fontSize: width * 0.033,
                                        color: MyMateThemes.textColor.withOpacity(0.7),
                                      ),
                                    ),

                                    // Dropdown list styling
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                        border: Border.all(
                                          color: MyMateThemes.textColor.withOpacity(0.1),
                                        ),
                                      ),
                                      offset: const Offset(0, -5), // slightly moves the dropdown list up
                                      padding: EdgeInsets.symmetric(vertical: height * 0.005),
                                    ),

                                    // Selected item appearance
                                    selectedItemBuilder: (BuildContext context) {
                                      return months.map<Widget>((String item) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              color: MyMateThemes.textColor.withOpacity(0.7),
                                              fontSize: width * 0.034,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },

                                    // Optional: icon styling (fix alignment)
                                    // icon: Icon(
                                    //   Icons.keyboard_arrow_down,
                                    //   color: MyMateThemes.textColor,
                                    //   size: width * 0.05,
                                    // ),

                                    // Fix internal spacing between text and icon
                                    buttonStyleData: ButtonStyleData(
                                      height: height * 0.055,
                                      width: width * 0.28,
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent, // already handled by outer container
                                        borderRadius: BorderRadius.circular(width * 0.01),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // SizedBox(
                              //   width:width * 0.28,
                              //   height:height * 0.055,
                              //   child:
                              //
                              //   DropdownButtonFormField<String>(
                              //     decoration: InputDecoration(
                              //       contentPadding: EdgeInsets.symmetric(horizontal:width * 0.02, vertical: width * 0.01), // Adjust padding
                              //       fillColor: MyMateThemes.containerColor,
                              //       filled: true,
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(width * 0.01),
                              //         borderSide: BorderSide.none,
                              //       ),
                              //     ),
                              //     value: selectedMonth,
                              //     items: months
                              //         .map((month) => DropdownMenuItem(
                              //       value: month,
                              //       child: Text(
                              //         month,
                              //         style: TextStyle(fontSize:width*0.034,color: MyMateThemes.textColor), // Smaller font size
                              //       ),
                              //     ))
                              //         .toList(),
                              //     onChanged: (value) {
                              //       setState(() {
                              //         selectedMonth = value;
                              //       });
                              //     },
                              //     hint: Text(
                              //       'Month',
                              //       style: TextStyle(fontSize:width*0.034,color: MyMateThemes.textColor.withOpacity(0.7)),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(width: width * 0.023),
                              Container(
                                width: width * 0.22,
                                height: height * 0.055,
                                decoration: BoxDecoration(
                                  color: MyMateThemes.containerColor,
                                  borderRadius: BorderRadius.circular(width * 0.01),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    value: selectedYear,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedYear = value;
                                      });
                                    },
                                    isExpanded: true,

                                    // Dropdown items
                                    items: years.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: width * 0.034,
                                            color: MyMateThemes.textColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),

                                    // Hint when nothing is selected
                                    hint: Text(
                                      'Year',
                                      style: TextStyle(
                                        fontSize: width * 0.034,
                                        color: MyMateThemes.textColor.withOpacity(0.7),
                                      ),
                                    ),

                                    // Dropdown list styling
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(width * 0.02),
                                        border: Border.all(
                                          color: MyMateThemes.textColor.withOpacity(0.1),
                                        ),
                                      ),
                                      offset: const Offset(0, -5),
                                      padding: EdgeInsets.symmetric(vertical: height * 0.005),
                                    ),

                                    // Selected item text appearance
                                    selectedItemBuilder: (BuildContext context) {
                                      return years.map<Widget>((String item) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              color: MyMateThemes.textColor.withOpacity(0.7),
                                              fontSize: width * 0.033,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },

                                    // Custom dropdown icon
                                    // icon: Icon(
                                    //   Icons.keyboard_arrow_down,
                                    //   color: MyMateThemes.textColor,
                                    //   size: width * 0.05,
                                    // ),

                                    // Button spacing and shape
                                    buttonStyleData: ButtonStyleData(
                                      height: height * 0.055,
                                      width: width * 0.22,
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(width * 0.01),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.06),
                              Container(
                                width:width * 0.26,
                                height:height * 0.055, // Reduced height
                                decoration: BoxDecoration(
                                  color: MyMateThemes.containerColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: TextField(
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4), // includes 3 spaces for format (16 + 3)

                                  ],
                                  showCursor: true,
                                  readOnly: false, // Prevent default keyboard
                                  onTap: () {
                                    setState(() {
                                      _activeController = _cvvController; // Set active controller
                                     _activeFocusNode = _cvvFocusNode;
                                     _activeFocusNode?.requestFocus(); // Request focus manually
                                    });
                                  },
                                  style: TextStyle(fontSize:width * 0.034,color: MyMateThemes.textColor), // Smaller font size
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal:width* 0.025, vertical:height* 0.023), // Adjust padding
                                    border: InputBorder.none,

                                  ),

                                ),
                              ),
                            ],
                          ),

                          SizedBox(height:height*0.04),
                          SizedBox(
                            height: height*0.08,
                            child: ElevatedButton(

                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => EditPage()),
                                // );
                              },
                              style:
                              ElevatedButton.styleFrom(

                                backgroundColor: MyMateThemes.premiumColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*0.01),
                                ),
                              ),
                              child: Text(
                                'Conform Payment',
                                style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16),
                              ),
                            ),
                          ),
                          // if (_activeController != null)
                          //   Container(
                          //     width:width*0.7, // Fixed width for the number pad
                          //     height: height*0.28,
                          //     padding: EdgeInsets.symmetric(vertical: height*0.015),
                          //     decoration: BoxDecoration(
                          //       color: MyMateThemes.secondaryColor,
                          //       borderRadius: BorderRadius.circular(width*0.02),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         // First row of the number pad
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             _numberPadButton('1'),
                          //             _numberPadButton('2'),
                          //             _numberPadButton('3'),
                          //           ],
                          //         ),
                          //         SizedBox(height: height*0.01),
                          //         // Second row of the number pad
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             _numberPadButton('4'),
                          //             _numberPadButton('5'),
                          //             _numberPadButton('6'),
                          //           ],
                          //         ),
                          //         SizedBox(height: height*0.01),
                          //         // Third row of the number pad
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             _numberPadButton('7'),
                          //             _numberPadButton('8'),
                          //             _numberPadButton('9'),
                          //           ],
                          //         ),
                          //         SizedBox(height: height*0.01),
                          //         // Fourth row of the number pad
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             _numberPadButton('C'), // Clear button
                          //             _numberPadButton('0'),
                          //             _numberPadButton('<'), // Backspace button
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                        //  SizedBox(height:height*0.02 ),

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
                  ),

          );
        }
      ),
    );

  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    // Remove all non-digit characters
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to 16 digits max
    final truncated = digitsOnly.substring(0, digitsOnly.length > 16 ? 16 : digitsOnly.length);

    // Format as xxxx xxxx xxxx xxxx
    final buffer = StringBuffer();
    for (int i = 0; i < truncated.length; i++) {
      buffer.write(truncated[i]);
      if ((i + 1) % 4 == 0 && i != truncated.length - 1) {
        buffer.write(' ');
      }
    }

    // Calculate new cursor position
    int offset = buffer.toString().length;

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: offset),
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
