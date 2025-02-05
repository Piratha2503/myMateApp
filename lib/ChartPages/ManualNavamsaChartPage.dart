import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscibe.dart';
import 'package:mymateapp/Homepages/SubscribedhomeScreen/SubscribedHomeScreenBeforeProfileCompleted.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';

import '../MyMateCommonBodies/MyMateApis.dart';
import '../dbConnection/Firebase_DB.dart';

class ManualNavamsaChartPage extends StatefulWidget {
  ClientData clientData;
  Astrology astrology;
  ManualNavamsaChartPage({required this.clientData,
    required this.astrology,
    super.key});

  @override
  State<ManualNavamsaChartPage> createState() => _ManualNavamsaChartPage();
}

class _ManualNavamsaChartPage extends State<ManualNavamsaChartPage> {
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
      tapped[planet] =
      !(tapped[planet] ?? false); // Provide a default value if null
    });
    print('$planet button pressed');
  }


  final List<Map<String, dynamic>> boxes = [
    {'boxNumber': 1, 'selectedTopBox': 1, 'assetName': '1'},
    {'boxNumber': 2, 'selectedTopBox': 1, 'assetName': '2'},
    {'boxNumber': 3, 'selectedTopBox': 1, 'assetName': '3'},
    {'boxNumber': 4, 'selectedTopBox': 1, 'assetName': '4'},
    {'boxNumber': 5, 'selectedTopBox': 1, 'assetName': '5'},
    {'boxNumber': 6, 'selectedTopBox': 1, 'assetName': '6'},
    {'boxNumber': 7, 'selectedTopBox': 1, 'assetName': '7'},
    {'boxNumber': 8, 'selectedTopBox': 1, 'assetName': '8'},
    {'boxNumber': 9, 'selectedTopBox': 1, 'assetName': '9'},
    {'boxNumber': 10, 'selectedTopBox': 1, 'assetName': '10'},
    {'boxNumber': 11, 'selectedTopBox': 1, 'assetName': '11'},
    {'boxNumber': 12, 'selectedTopBox': 1, 'assetName': '12'},
  ];

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
      tapped[button] =
      !(tapped[button] ?? false);
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
        if (segmentToBoxMap.containsKey(segment) &&
            segmentToBoxMap[segment] == selectedTopBox) {
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

  Future <void> _storeSelections() async{
    FirebaseDB firebaseDB = FirebaseDB();

    ChartGeneration chartGeneration = ChartGeneration();
    List<String> option1List = [];
    List<String> option2List = [];
    List<String> option3List = [];
    List<String> option4List = [];
    List<String> option5List = [];
    List<String> option6List = [];
    List<String> option7List = [];
    List<String> option8List = [];
    List<String> option9List = [];
    List<String> option10List = [];
    List<String> option11List = [];
    List<String> option12List = [];

    for (var element in segmentToBoxMap.entries) {
      switch(element.value) {
        case 1: option1List.add(element.key);
        case 2: option2List.add(element.key);
        case 3: option3List.add(element.key);
        case 4: option4List.add(element.key);
        case 5: option5List.add(element.key);
        case 6: option6List.add(element.key);
        case 7: option7List.add(element.key);
        case 8: option8List.add(element.key);
        case 9: option9List.add(element.key);
        case 10: option10List.add(element.key);
        case 11: option11List.add(element.key);
        case 12: option12List.add(element.key);
      }
    }

    chartGeneration.place1 = option1List;
    chartGeneration.place2 = option2List;
    chartGeneration.place3 = option3List;
    chartGeneration.place4 = option4List;
    chartGeneration.place5 = option5List;
    chartGeneration.place6 = option6List;
    chartGeneration.place7 = option7List;
    chartGeneration.place8 = option8List;
    chartGeneration.place9 = option9List;
    chartGeneration.place10 = option10List;
    chartGeneration.place11 = option11List;
    chartGeneration.place12 = option12List;

    widget.astrology.navamsa_chart = chartGeneration;
    widget.clientData.astrology = widget.astrology;

    // 🔹 Call the API instead of Firebase
    await updateClientData(widget.clientData);

    print(chartGeneration.place1);
    print(chartGeneration.place2);
    print(chartGeneration.place3);
    print(chartGeneration.place4);
    print(chartGeneration.place5);
    print(chartGeneration.place6);
    print(chartGeneration.place7);
    print(chartGeneration.place8);
    print(chartGeneration.place9);
    print(chartGeneration.place10);
    print(chartGeneration.place11);
    print(chartGeneration.place12);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscribedhomescreenBeforeProfileCompleted(docId: widget.clientData.docId!,)));

  }

  Widget buildTopBox(int boxNumber, String assetName) {
    return GestureDetector(
      onTap: () => _onTapTopBox(boxNumber),
      child: Container(
        width: 57,
        height: 48,
        decoration: BoxDecoration(
          color: (selectedTopBox == boxNumber) ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor ,
          borderRadius: BorderRadius.circular(6), // Optional rounded corners
        ),
        padding: const EdgeInsets.all(16), // Padding inside the box
        child: Center(
          child: Text(
            assetName,
            style: TextStyle(
              color: (selectedTopBox == boxNumber) ? MyMateThemes.backgroundColor  : MyMateThemes.textColor ,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),


        ),
      ),
    );
  }


  Widget buildBottomSegment(String segment, String assetName,String selectedAssetName) {
    return GestureDetector(
      onTap: () => _onTapBottomSegment(segment),
      child: Stack(
        children: [
          // Opacity(
          //   opacity: isSegmentSelected(segment) ? 0.8 : 1.0, // Keeping opacity same
          //   child: SvgPicture.asset(
          //     assetName,
          //     color: isSegmentSelected(segment) ? MyMateThemes.secondaryColor : MyMateThemes.primaryColor, // Change color based on selection
          //   ),
          // ),
          Opacity(
            opacity: 1.0, // Keep opacity constant
            child: SvgPicture.asset(
              isSegmentSelected(segment) ? selectedAssetName : assetName, // Dynamically change asset
            ),
          ),
          // Opacity(
          //   opacity: isSegmentSelected(segment) ? 0.7 : 1.0,
          //   child: SvgPicture.asset(assetName),
          // ),
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
      backgroundColor:Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10),
          SafeArea(
            child: Column(
              children: [
                Text(
                  "Enter Chart Navamsa",
                  style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8
                  ),
                ),
                Text(
                  "to calculate Astrology Chart",
                  style: TextStyle(
                      color: MyMateThemes.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height:10),
          Card(
            elevation: 4.0, // Adjust elevation as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            child: Container(
              width: 300,
              height: 188,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0), // Match the border radius of the Card
              ),
              child: Column(
                children: [
                  Expanded(
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 14 / 11,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      children: boxes.map((box) {
                        return buildTopBox(box['boxNumber'], box['assetName']);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height:20),

          // Container(
          //   width: 310,
          //   height: 208,
          //   color: Colors.white,
          //   child: Column(
          //     children: [
          //       SizedBox(height: 4),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           SizedBox(width: 10),
          //           buildTopBox(1, 'assets/images/one.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(2, 'assets/images/two.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(3, 'assets/images/three.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(4, 'assets/images/four.svg'),
          //           SizedBox(width: 10),
          //         ],
          //       ),
          //       SizedBox(height: 4),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           SizedBox(width: 10),
          //           buildTopBox(5, 'assets/images/five.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(6, 'assets/images/six.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(7, 'assets/images/seven.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(8, 'assets/images/eight.svg'),
          //           SizedBox(width: 10),
          //         ],
          //       ),
          //      // SizedBox(height: 10),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           SizedBox(width: 10),
          //           buildTopBox(9, 'assets/images/nine.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(10, 'assets/images/ten.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(11, 'assets/images/eleven.svg'),
          //           SizedBox(width: 10),
          //           buildTopBox(12, 'assets/images/twelve.svg'),
          //           SizedBox(width: 10),
          //         ],
          //       ),
          //      // SizedBox(height: 10),
          //     ],
          //   ),
          // ),
          Center(child:

          DecoratedBox(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),

            child:
            Container(
              height: 330,
              width: 305,
              color: MyMateThemes.backgroundColor,
              child: Stack(
                children: [
                  Positioned(
                      top: 88,
                      left: 88,
                      child:
                      buildBottomSegment('Sun', 'assets/images/p_sun.svg','assets/images/s_sun.svg')),
                  Positioned(
                      left: 217,
                      top: 60,
                      child: buildBottomSegment(
                          'Mercury', 'assets/images/p_mercury.svg','assets/images/s_mercury.svg')),
                  Positioned(
                      left: 156,
                      top: 15,
                      child:
                      buildBottomSegment('Mars', 'assets/images/p_mars.svg','assets/images/s_mars.svg')),
                  Positioned(
                      left: 57,
                      top: 229,
                      child: buildBottomSegment(
                          'Saturn', 'assets/images/p_saturn.svg','assets/images/s_saturn.svg')),
                  Positioned(
                      left: 217,
                      top: 168,
                      child: buildBottomSegment(
                          'Jupiter', 'assets/images/p_jupitor.svg','assets/images/s_jupiter.svg')),
                  Positioned(
                      left:8,
                      top: 172,
                      child:
                      buildBottomSegment('Rahu', 'assets/images/p_rahu.svg','assets/images/s_rahu.svg')),
                  Positioned(
                      left:6,
                      top: 68,
                      child:
                      buildBottomSegment('Ketu', 'assets/images/p_ketu.svg','assets/images/s_ketu.svg')),
                  Positioned(
                      left: 163,
                      top: 227,
                      child: buildBottomSegment(
                          'Venus', 'assets/images/p_venus.svg','assets/images/s_venus.svg')),
                  Positioned(
                      left: 49,
                      top: 16,
                      child:
                      buildBottomSegment('Moon', 'assets/images/p_moon.svg','assets/images/s_moon.svg')),
                ],
              ),
            ),
          ),
    ),
      SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _resetSelections,
                child: SvgPicture.asset('assets/images/ast_edit.svg'),
              ),
              SizedBox(width: 18),
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
          ),
        ],
      ),
    );
  }
}
