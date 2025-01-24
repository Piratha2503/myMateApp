import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/ChartPages/ManualNavamsaChartPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';

class ManualRasiChartPage extends StatefulWidget {
  ClientData clientData;
  ManualRasiChartPage({required this.clientData,super.key});

  @override
  State<ManualRasiChartPage> createState() => _ManualRasiChartPage();
}

class _ManualRasiChartPage extends State<ManualRasiChartPage> {

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

  int? selectedTopBox;

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

  Map<String, int> segmentToBoxMap = {};

  get identifier => null;

  bool isSegmentSelected(String segment) { return segmentToBoxMap.containsKey(segment); }

  int? getSegmentBadge(String segment) { return segmentToBoxMap[segment];}

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

    Astrology astrology = Astrology(rasi_chart: chartGeneration);
    widget.clientData.astrology = astrology;
    await firebaseDB.updateClient(widget.clientData);

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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ManualNavamsaChartPage(clientData: widget.clientData,
      astrology: astrology,
    )));

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
                Text( "Enter Chart Rasi",
                  style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
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
                // Add more Positioned widgets for other buttons similarly
              ],
            ),
          ),
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


          DecoratedBox(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: Container(
              height: 330,
              width: 300,
              color: MyMateThemes.backgroundColor,
              child: Stack(
                children: [
                  Positioned(
                      top: 110,
                      left: 80,
                      child:
                      buildBottomSegment('Sun', 'assets/images/Sun.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 207,
                      top: 74,
                      child: buildBottomSegment(
                          'Mercury', 'assets/images/Mercury.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 152,
                      top: 30,
                      child:
                      buildBottomSegment('Mars', 'assets/images/Mars.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 55,
                      top: 245,
                      child: buildBottomSegment(
                          'Saturn', 'assets/images/Saturn.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 213,
                      top: 178,
                      child: buildBottomSegment(
                          'Jupiter', 'assets/images/Jupiter.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 0,
                      top: 185,
                      child:
                      buildBottomSegment('Rahu', 'assets/images/Rahu.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 0,
                      top: 82,
                      child:
                      buildBottomSegment('Ketu', 'assets/images/Ketu.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 159,
                      top: 239,
                      child: buildBottomSegment(
                          'Venus', 'assets/images/Venus.svg','assets/images/Mercury.svg')),
                  Positioned(
                      left: 47,
                      top: 30,
                      child:
                      buildBottomSegment('Moon', 'assets/images/Moon.svg','assets/images/Mercury.svg')),
                ],
              ),
            ),
          ),
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