import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ManualRasiChartPageTest extends StatefulWidget {
  const ManualRasiChartPageTest({super.key});

  @override
  State<ManualRasiChartPageTest> createState() => _ManualRasiChartPageTestState();
}

class _ManualRasiChartPageTestState extends State<ManualRasiChartPageTest> {
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
  int? selectedTopBox;

  void _onSelect(String button) {
    setState(() {
      tapped[button] =
      !(tapped[button] ?? false); // Provide a default value if null
    });
    print('$button button pressed');
  }

  void _onTap(String planet) {
    setState(() {
      tapped[planet] =
      !(tapped[planet] ?? false); // Provide a default value if null
    });
    print('$planet button pressed');
  }

  void _onTapTopBox(int boxNumber) {
    setState(() {
      selectedTopBox = boxNumber;
    });
  }
  Map<String, int> segmentToBoxMap = {};

  bool isSegmentSelected(String segment) {
    return segmentToBoxMap.containsKey(segment);
  }

  int? getSegmentBadge(String segment) {
    return segmentToBoxMap[segment];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Instructions(),
          SizedBox(height: 20),
          TopBoxes(),
          SizedBox(height: 10),
          NavagragaCircle(),
          SizedBox(height: 20),
          IncompleteWarningMessage(),
        ],
      ),
    );
  }
}

class buildTopBox extends StatefulWidget{
  int boxNumber;
  String assetName;
  int selectedTopBox;
  buildTopBox({required this.boxNumber, required this.selectedTopBox,required this.assetName});
  @override
  State<buildTopBox> createState() => _buidTopBoxState();
}

class _buidTopBoxState extends State<buildTopBox>{

  void _onTapTopBox(int boxNumber) {
    setState(() {
      widget.selectedTopBox = boxNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapTopBox(widget.boxNumber),
      child: Opacity(
        opacity: (widget.selectedTopBox == widget.boxNumber) ? 1.0 : 0.6,
        child: SvgPicture.asset(widget.assetName),
      ),
    );
  }
}

Widget Instructions(){
  return SafeArea(
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
        // Add more Positioned widgets for other buttons similarly
      ],
    ),
  );
}

Widget TopBoxes(){

  final List<Map<String, dynamic>> boxes = [
    {'boxNumber': 1, 'selectedTopBox': 1, 'assetName': 'assets/images/one.svg'},
    {'boxNumber': 2, 'selectedTopBox': 1, 'assetName': 'assets/images/two.svg'},
    {'boxNumber': 3, 'selectedTopBox': 1, 'assetName': 'assets/images/three.svg'},
    {'boxNumber': 4, 'selectedTopBox': 1, 'assetName': 'assets/images/four.svg'},
    {'boxNumber': 5, 'selectedTopBox': 1, 'assetName': 'assets/images/five.svg'},
    {'boxNumber': 6, 'selectedTopBox': 1, 'assetName': 'assets/images/six.svg'},
    {'boxNumber': 7, 'selectedTopBox': 1, 'assetName': 'assets/images/seven.svg'},
    {'boxNumber': 8, 'selectedTopBox': 1, 'assetName': 'assets/images/eight.svg'},
    {'boxNumber': 9, 'selectedTopBox': 1, 'assetName': 'assets/images/nine.svg'},
    {'boxNumber': 10, 'selectedTopBox': 1, 'assetName': 'assets/images/ten.svg'},
    {'boxNumber': 11, 'selectedTopBox': 1, 'assetName': 'assets/images/eleven.svg'},
    {'boxNumber': 12, 'selectedTopBox': 1, 'assetName': 'assets/images/twelve.svg'},
  ];

  return Container(
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
            buildTopBox(boxNumber: 1, selectedTopBox: 1, assetName: 'assets/images/one.svg',),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 2,selectedTopBox: 1,assetName: 'assets/images/two.svg',),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 3, selectedTopBox: 1,assetName: 'assets/images/three.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 4,selectedTopBox: 1, assetName: 'assets/images/four.svg'),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 10),
            buildTopBox(boxNumber: 5, selectedTopBox: 1,assetName: 'assets/images/five.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 6, selectedTopBox: 1,assetName: 'assets/images/six.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 7, selectedTopBox: 1,assetName: 'assets/images/seven.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 8, selectedTopBox: 1,assetName: 'assets/images/eight.svg'),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 10),
            buildTopBox(boxNumber: 9, selectedTopBox: 1,assetName: 'assets/images/nine.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 10, selectedTopBox: 1,assetName: 'assets/images/ten.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 11, selectedTopBox: 1,assetName: 'assets/images/eleven.svg'),
            SizedBox(width: 10),
            buildTopBox(boxNumber: 12, selectedTopBox: 1,assetName: 'assets/images/twelve.svg'),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

Widget NavagragaCircle(){
  return DecoratedBox(
    decoration: ShapeDecoration(shape: CircleBorder(),),
    child: Container(
      height: 350,
      width: 350,
      color: MyMateThemes.backgroundColor,
      child: Stack(
        children: [
          SizedBox(width: 20),
          Positioned(top: 110,left: 80,child: buildBottomSegment(segment: 'Sun', selectedTopBox: 2,assetName: 'assets/images/Sun.svg')),
          Positioned(left: 207,top: 74,child: buildBottomSegment(segment: 'Mercury', selectedTopBox: 4,assetName: 'assets/images/Mercury.svg')),
          Positioned(left: 152,top: 30,child: buildBottomSegment(segment: 'Mars', selectedTopBox: 3,assetName: 'assets/images/Mars.svg')),
          Positioned(left: 55,top: 245,child: buildBottomSegment(segment: 'Saturn', selectedTopBox: 1,assetName: 'assets/images/Saturn.svg')),
          Positioned(left: 213,top: 178,child: buildBottomSegment(segment: 'Jupiter', selectedTopBox: 1,assetName: 'assets/images/Jupiter.svg')),
          Positioned(left: 0,top: 185,child: buildBottomSegment(segment: 'Rahu', selectedTopBox: 1,assetName: 'assets/images/Rahu.svg')),
          Positioned(left: 0,top: 82,child: buildBottomSegment(segment: 'Ketu', selectedTopBox: 1,assetName: 'assets/images/Ketu.svg')),
          Positioned(left: 159,top: 239,child: buildBottomSegment(segment: 'Venus', selectedTopBox: 1,assetName: 'assets/images/Venus.svg')),
          Positioned(left: 47,top: 30,child: buildBottomSegment(segment: 'Moon', selectedTopBox: 1,assetName: 'assets/images/Moon.svg')),
        ],
      ),
    ),
  );
}

class buildBottomSegment extends StatefulWidget{
  String segment;
  String assetName;
  int selectedTopBox;
  buildBottomSegment({super.key,required this.segment,required this.assetName,required this.selectedTopBox,});

  @override
  State<buildBottomSegment> createState() => _buildBottomSegmentState();
}

class _buildBottomSegmentState extends State<buildBottomSegment>{

  Map<String, int> segmentToBoxMap = {};

  void _onTapTopBox(int boxNumber) {
    setState(() {
      widget.selectedTopBox = boxNumber;
    });
  }


  bool isSegmentSelected(String segment) {
    return segmentToBoxMap.containsKey(segment);
  }

  int? getSegmentBadge(String segment) {
    return segmentToBoxMap[segment];
  }
  void _onTapBottomSegment(String segment) {
    if (widget.selectedTopBox != null) {
      setState(() {
        if (segmentToBoxMap.containsKey(segment) &&
            segmentToBoxMap[segment] == widget.selectedTopBox) {
          segmentToBoxMap.remove(segment);
        } else {
          segmentToBoxMap[segment] = widget.selectedTopBox;
        }
      });
    }
    print('$segment button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapBottomSegment(widget.segment),
      child: Stack(
        children: [
          Opacity(
            opacity: isSegmentSelected(widget.segment) ? 0.7 : 1.0,
            child: SvgPicture.asset(widget.assetName),
          ),
          if (getSegmentBadge(widget.segment) != null)
            Positioned(
              top: 10,
              right: 15,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: MyMateThemes.premiumAccent,
                child: Text(
                  getSegmentBadge(widget.segment).toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

}

class IncompleteWarningMessage extends StatefulWidget{
  IncompleteWarningMessage({super.key});

  @override
  State<IncompleteWarningMessage> createState() => _IncompleteWarningMessageState();
}

class _IncompleteWarningMessageState extends State<IncompleteWarningMessage>{

  int? selectedTopBox;
  Map<String, int> segmentToBoxMap = {};

  bool isSegmentSelected(String segment) {
    return segmentToBoxMap.containsKey(segment);
  }

  int? getSegmentBadge(String segment) {
    return segmentToBoxMap[segment];
  }

  void _storeSelections() {
    print('Selections stored: $segmentToBoxMap');
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

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  content: Text(
                      'Please complete all selections before proceeding.'),
                ),
              );
            }
          },
          child: SvgPicture.asset('assets/images/can.svg'),
        ),
      ],
    );
  }

}