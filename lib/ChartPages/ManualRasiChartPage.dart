import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ManualRasiChartPage extends StatefulWidget {
  const ManualRasiChartPage({Key? key}) : super(key: key);

  @override
  State<ManualRasiChartPage> createState() => _ManualRasiChartPage();
}

class _ManualRasiChartPage extends State<ManualRasiChartPage> {
  // Define the initial state for the SVGs
  Map<String, bool> tapped = {
    'Sun': false,
    'Mercury': false,
    'Mars': false,
    'Saturn': false,
    'Jupiter': false,
    'Rahu': false,
    'Ketu': false,
    'Venus': false,
    'Moon': false,
  };

  get identifier => null;

  // Function to handle the tap and change the state
  void _onTap(String planet) {
    setState(() {
      tapped[planet] = !(tapped[planet] ?? false); // Provide a default value if null
    });
    print('$planet button pressed');
  }

  Map<String, bool> selected = {
    'one': false,
    'two': false,
    'three': false,
    'four': false,
    'five': false,
    'six': false,
    'seven': false,
    'eight': false,
    'nine': false,
    'ten': false,
    'eleven': false,
    'twelve': false,
  };

  void _onSelect(String button) {
    setState(() {
      tapped[button] = !(tapped[button] ?? false); // Provide a default value if null
    });
    print('$button button pressed');
  }

  int? selectedTopBox;
  Map<String, int> segmentToBoxMap = {};

  bool isSegmentSelected(String segment) {
    return segmentToBoxMap.containsKey(segment);
  }

  int? getSegmentBadge(String segment) {
    return segmentToBoxMap[segment];
  }

  void _onTapTopBox(int boxNumber) {
    setState(() {
      selectedTopBox = boxNumber;
    });
  }

  void _onTapBottomSegment(String segment) {
    if (selectedTopBox != null) {
      setState(() {
        if (segmentToBoxMap.containsKey(segment) && segmentToBoxMap[segment] == selectedTopBox) {
          segmentToBoxMap.remove(segment);
        } else {
          segmentToBoxMap[segment] = selectedTopBox!;
        }
      });
    }
    print('$segment button pressed');
  }

  void _resetSelections() {
    setState(() {
      segmentToBoxMap.clear();
      selectedTopBox = null;
    });
  }

  bool _areAllSelectionsComplete() {
    // Define the list of all required segments
    List<String> requiredSegments = [
      'Sun',
      'Mercury',
      'Mars',
      'Saturn',
      'Jupiter',
      'Rahu',
      'Ketu',
      'Venus',
      'Moon'
    ];

    // Check if each required segment has a selection
    for (String segment in requiredSegments) {
      if (!segmentToBoxMap.containsKey(segment)) {
        return false;
      }
    }
    return true;
  }

  void _storeSelections() {
    // Implement the logic to store selections as needed
    print('Selections stored: $segmentToBoxMap');
  }

  Widget buildTopBox(int boxNumber, String assetName) {
    return GestureDetector(
      onTap: () => _onTapTopBox(boxNumber),
      child: Opacity(
        opacity: (selectedTopBox == boxNumber) ? 1.0 : 0.6,
        child: SvgPicture.asset(assetName),
      ),
    );
  }

  Widget buildBottomSegment(String segment, String assetName) {
    return GestureDetector(
      onTap: () => _onTapBottomSegment(segment),
      child: Stack(
        children: [
          Opacity(
            opacity: isSegmentSelected(segment) ? 0.7 : 1.0,
            child: SvgPicture.asset(assetName),
          ),
          if (getSegmentBadge(segment) != null)
            Positioned(
              top: 10,
              right: 15,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: MyMateThemes.premiumAccent,
                child: Text(
                  getSegmentBadge(segment).toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          SafeArea(
            child: Column(
              children: [
                Text(
                  "Enter Chart Rasi",
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "to calculate Astrology Chart",
                  style: TextStyle(
                    color: MyMateThemes.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 310,
            height: 208,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 10),
                    buildTopBox(1, 'assets/images/one.svg'),
                    SizedBox(width: 10),
                    buildTopBox(2, 'assets/images/two.svg'),
                    SizedBox(width: 10),
                    buildTopBox(3, 'assets/images/three.svg'),
                    SizedBox(width: 10),
                    buildTopBox(4, 'assets/images/four.svg'),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 10),
                    buildTopBox(5, 'assets/images/five.svg'),
                    SizedBox(width: 10),
                    buildTopBox(6, 'assets/images/six.svg'),
                    SizedBox(width: 10),
                    buildTopBox(7, 'assets/images/seven.svg'),
                    SizedBox(width: 10),
                    buildTopBox(8, 'assets/images/eight.svg'),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 10),
                    buildTopBox(9, 'assets/images/nine.svg'),
                    SizedBox(width: 10),
                    buildTopBox(10, 'assets/images/ten.svg'),
                    SizedBox(width: 10),
                    buildTopBox(11, 'assets/images/eleven.svg'),
                    SizedBox(width: 10),
                    buildTopBox(12, 'assets/images/twelve.svg'),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 20),
          DecoratedBox(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: Container(
              height: 350,
              width: 350,
              color: MyMateThemes.backgroundColor,
              child: Stack(
                children: [
                  Positioned(top: 110, left: 80, child: buildBottomSegment('Sun', 'assets/images/Sun.svg')),
                  Positioned(left: 207, top: 74, child: buildBottomSegment('Mercury', 'assets/images/Mercury.svg')),
                  Positioned(left: 152, top: 30, child: buildBottomSegment('Mars', 'assets/images/Mars.svg')),
                  Positioned(left: 55, top: 245, child: buildBottomSegment('Saturn', 'assets/images/Saturn.svg')),
                  Positioned(left: 213, top: 178, child: buildBottomSegment('Jupiter', 'assets/images/Jupiter.svg')),
                  Positioned(left: 0, top: 185, child: buildBottomSegment('Rahu', 'assets/images/Rahu.svg')),
                  Positioned(left: 0, top: 82, child: buildBottomSegment('Ketu', 'assets/images/Ketu.svg')),
                  Positioned(left: 159, top: 239, child: buildBottomSegment('Venus', 'assets/images/Venus.svg')),
                  Positioned(left: 47, top: 30, child: buildBottomSegment('Moon', 'assets/images/Moon.svg')),
                ],
              ),
            ),
          ),
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: _resetSelections,
                child: SvgPicture.asset('assets/images/ast_edit.svg'),
              ),
              GestureDetector(
                onTap: () {
                  if (_areAllSelectionsComplete()) {
                    _storeSelections();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please complete all selections before proceeding.'),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset('assets/images/can.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
