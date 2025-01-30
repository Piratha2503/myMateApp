import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/Homepages/Profiles/boost_profile.dart';
import 'package:mymateapp/MyMateCommonBodies/RouterFunction.dart';

import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';
import '../Profiles/EditPage.dart';
import '../Profiles/MoreAboutMe.dart';

Widget IconWithText(String iconPath, String text1, String text2) {
  return Container(
    width: 120,
    height: 72,
    foregroundDecoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: MyMateThemes.secondaryColor,
          width: 2,
        ),
      ),
    ),
    child: Column(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(height: 5),
        Text(
          text1,
          style: TextStyle(
            color: MyMateThemes.textColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: MyMateThemes.primaryColor,
            fontSize: 10,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget ActionButtons(BuildContext context, String docId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          NavigatorFunction(
              context,
              boostprofile(
                docId: docId,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyMateThemes.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Boost ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      SizedBox(width: 60),
      ElevatedButton(
        onPressed: () {
          NavigatorFunction(
              context,
              EditPage(
                docId: docId,
                onSave: () {},
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyMateThemes.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

Widget Containers({required List<Widget> children}) {
  return Column(
    children: children,
  );
}

final List<String> _alcoholOptions = [
  'Never Had',
  'Rarely Drinker',
  'Occasionally Drinker',
  'Regularly Drinker',
  'Swimming in it (24/7)',
];
final List<String> _smokingOptions = [
  'Never Had',
  'Rarely Smoker',
  'Occasionally Smoker',
  'Regularly Smoker',
  'Chain Smoker',
];

final List<String> _cookingOptions = [
  'Zero',
  'Novice',
  'Basic',
  'Intermediate',
  'Advanced',
];

class AdditionalInfo extends StatefulWidget {
  final String docId;
  const AdditionalInfo({Key? key,required this.docId}) : super(key: key);

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  int selectedAlcoholIndex = -1;
  int selectedSmokingIndex = -1;
  int selectedCookingIndex = -1;

  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController favoritesController = TextEditingController();
  final TextEditingController sportsController = TextEditingController();

  List<String> hobbyTags = [];
  List<String> favoritesTags = [];
  List<String> sportsTags = [];

  String _selectedValue = '';

  int _getIndexFromString(String value, List<String> options) {
    return options.indexOf(value);
  }

  Future<void> _fetchClientDetails() async {
    try {
      final data = await fetchUserById(widget.docId);

      if (data.isNotEmpty) {
        setState(() {
          _selectedValue = data['eating_habit'] ?? '';
          selectedAlcoholIndex =
              _getIndexFromString(data['alcoholIntake'], _alcoholOptions);
          selectedSmokingIndex =
              _getIndexFromString(data['smoking'], _smokingOptions);
          selectedCookingIndex =
              _getIndexFromString(data['cooking'], _cookingOptions);
          hobbyTags = List<String>.from(data['favorites'] ?? []);
        });
      }
      print(selectedSmokingIndex);
      print(selectedAlcoholIndex);
      print(selectedCookingIndex);

    } catch (e) {
      print('Error occurred while fetching client details: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClientDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 40),
              Text(
                'Personal Interest',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 35),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 15),
          _buildTextField(hobbyController, 'Personal Interest'),
          SizedBox(height: 20),
          Wrap(
            children: hobbyTags.map((tag) => _buildTag(tag)).toList(),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: 45),
              Text(
                'Habits',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 35),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 45),
              Text(
                'Eating Habits',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Radio<String>(
                    value: 'Vegetarian',
                    groupValue: _selectedValue,
                    onChanged: null, // Disable interaction
                    activeColor: MyMateThemes.primaryColor,
                  ),
                  Text('Vegetarian'),
                ],
              ),
              SizedBox(width: 50),
              Row(
                children: [
                  Radio<String>(
                    value: 'Non- Vegetarian',
                    groupValue: _selectedValue,
                    onChanged: null, // Disable interaction
                    activeColor: MyMateThemes.primaryColor,
                  ),
                  Text('Non- Vegetarian'),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 45),
              Text(
                'Alcohol',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          _buildAlcoholSelection(selectedAlcoholIndex,context),
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 45),
              Text(
                'Smoking',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          _buildSmokingSelection(selectedSmokingIndex,context),
          SizedBox(height: 45),
          Row(
            children: [
              SizedBox(width: 45),
              Text(
                'Cooking',
                style: TextStyle(
                  color: MyMateThemes.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 35),
              SvgPicture.asset('assets/images/Line 11.svg'),
            ],
          ),
          SizedBox(height: 30),
          _buildCookingSelection(selectedCookingIndex,context),
        ],
      ),
    );
  }
}

Widget Tag(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    ),
  );
}

Widget SectionTitle(String title) {
  return Row(
    children: [
      SizedBox(width: 40),
      SvgPicture.asset('assets/images/Group 2148.svg'),
      SizedBox(width: 4),
      Text(
        title,
        style: TextStyle(
          color: MyMateThemes.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildTextField(TextEditingController controller, String hintText) {
  return Container(
    decoration: BoxDecoration(
      color: MyMateThemes.containerColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    width: 330,
    height: 37,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: TextField(
        controller: controller,
        enabled: false, // Disable editing
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyMateThemes.textColor.withOpacity(0.5)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(9.0),
          hintText: hintText,
        ),
      ),
    ),
  );
}

Widget _buildTag(String text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: MyMateThemes.primaryColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
    ),
  );
}

Widget _buildAlcoholSelection(
    final int selectedAlcoholIndex,
    BuildContext context,
    ) {
  return Stack(
    children: [
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 24),
        painter: _LinePainter(selectedAlcoholIndex: selectedAlcoholIndex),
      ),
      Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Column(
                children: [
                  CustomPaint(
                    painter:
                    _CirclePainter(isActive: selectedAlcoholIndex >= i),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(
                    _alcoholOptions[i].split(' ')[0],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

Widget _buildSmokingSelection(
    final int selectedSmokingIndex,
    BuildContext context,
    ) {
  return Stack(
    children: [
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 24),
        painter: _SmokingLinePainter(selectedSmokingIndex: selectedSmokingIndex),
      ),
      Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Column(
                children: [
                  CustomPaint(
                    painter:
                    _CirclePainter(isActive: selectedSmokingIndex >= i),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(
                    _smokingOptions[i].split(' ')[0],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

Widget _buildCookingSelection(
    final int selectedCookingIndex,
    BuildContext context,
    ) {

  return Stack(
    children: [
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 24),
        painter: _LinearPainter(selectedCookingIndex: selectedCookingIndex),
      ),
      Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Column(
                children: [
                  CustomPaint(
                    painter:
                    _CirclePainter(isActive: selectedCookingIndex >= i),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(
                    _cookingOptions[i],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

class _CirclePainter extends CustomPainter {
  final bool isActive;

  _CirclePainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
      isActive ? MyMateThemes.primaryColor : Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _LinePainter extends CustomPainter {
  final int selectedAlcoholIndex;

  _LinePainter({required this.selectedAlcoholIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 4;

    final double segmentWidth = size.width / 5;

    for (int i = 0; i < 4; i++) {
      paint.color = i < selectedAlcoholIndex
          ? MyMateThemes.primaryColor
          : Colors.grey.withOpacity(0.1);
      canvas.drawLine(
        Offset((i + 0.5) * segmentWidth, size.height / 2),
        Offset((i + 1.5) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _SmokingLinePainter extends CustomPainter {
  final int selectedSmokingIndex;

  _SmokingLinePainter({required this.selectedSmokingIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 4;

    final double segmentWidth = size.width / 5;

    for (int i = 0; i < 4; i++) {
      paint.color = i < selectedSmokingIndex
          ? MyMateThemes.primaryColor
          : Colors.grey.withOpacity(0.1);
      canvas.drawLine(
        Offset((i + 0.5) * segmentWidth, size.height / 2),
        Offset((i + 1.5) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _LinearPainter extends CustomPainter {
  final int selectedCookingIndex;

  _LinearPainter({required this.selectedCookingIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyMateThemes.primaryColor
      ..strokeWidth = 4;

    final double segmentWidth = size.width / 5;

    for (int i = 0; i < 4; i++) {
      paint.color = i < selectedCookingIndex
          ? MyMateThemes.primaryColor
          : Colors.grey.withOpacity(0.1);
      canvas.drawLine(
        Offset((i + 0.5) * segmentWidth, size.height / 2),
        Offset((i + 1.5) * segmentWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
