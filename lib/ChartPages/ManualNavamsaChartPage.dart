import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Homepages/HomeScreenBeforeSubscribe.dart';
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

    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenBeforeSubscibe(0,docId: widget.clientData.docId!,)));

  }

  Widget buildTopBox(int boxNumber, String assetName) {
    return GestureDetector(
      onTap: () => _onTapTopBox(boxNumber),
      child: Container(
        decoration: BoxDecoration(
          color: (selectedTopBox == boxNumber) ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            assetName,
            style: TextStyle(
              color: (selectedTopBox == boxNumber) ? MyMateThemes.backgroundColor : MyMateThemes.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }


  Widget buildBottomSegment(
      String segment,
      String assetName,
      String selectedAssetName, {
        double? top,
        double? right,
        double? left,
        double? bottom,
        required double width,
        required double height,
        required BoxFit fit
      }) {
    return GestureDetector(
      onTap: () => _onTapBottomSegment(segment),
      child: Stack(
        children: [
          Opacity(
            opacity: 1.0,
            child: SvgPicture.asset(
              isSegmentSelected(segment) ? selectedAssetName : assetName,
            ),
          ),
          if (getSegmentBadge(segment) != null)
            Positioned(
              top: top ?? 20,
              right: right ?? 10,
              left: left,
              bottom: bottom,
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

    return LayoutBuilder(
        builder: (context, constraints) {
          // Read width and height from constraints to use for responsive sizing.
          final mediaQuery = MediaQuery.of(context);
          final double width = mediaQuery.size.width;
          final double height = mediaQuery.size.height;
          double svgWidth = width * 0.5;
          double svgHeight = height * 0.5;

          return Scaffold(

            backgroundColor: Colors.white,

            body:
            LayoutBuilder(

              builder: (context, constraints) {


                return
                  Center(
                    child: Column(
                      children: [
                        SafeArea(
                          child:
                          Column(
                            children: [
                              SizedBox(height: height*0.02),

                              Text(
                                "Enter Chart Navamsa",
                                style: TextStyle(
                                  color: MyMateThemes.textColor,
                                  fontSize: width*0.05,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,

                                ),

                              ),

                              Text(
                                "to calculate Astrology Chart",
                                style: TextStyle(
                                  color: MyMateThemes.primaryColor,
                                  fontSize: width*0.05,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,

                                ),

                              ),

                            ],

                          ),

                        ),
                        SizedBox(height: height*0.01),
                        Container(

                          width: width*0.65,

                          height: height*0.26,

                          decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius: BorderRadius.circular(width*0.02),

                          ),

                          child: GridView.count(

                            // crossAxisCount: constraints.maxWidth > 600 ? 6 : 4,
                            crossAxisCount: 4,

                            childAspectRatio: width / (height * 0.45),
                            crossAxisSpacing: width * 0.02,
                            mainAxisSpacing: height * 0.02,

                            padding: EdgeInsets.all(width*0.001),

                            children: List.generate(12, (index) => buildTopBox(index + 1, '${index + 1}')),

                          ),

                        ),
                        SizedBox(height: height*0.01,),

                        Center(child:

                        DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                          ),

                          child:
                          Container(
                            height: height*0.46,
                            width: width*0.86,
                            // width: width*0.77,

                            decoration: BoxDecoration(
                              //  borderRadius: BorderRadius.circular(300),
                              color: Colors.white,

                            ),
                            child:
                            Stack(

                              alignment: Alignment.center,

                              children: [
                                Positioned(
                                  top: -5,
                                  left: -4,
                                  child:
                                  SvgPicture.asset(
                                    'assets/images/centercircle.svg',
                                   //  color: MyMateThemes.textColor.withOpacity(0.05),
                                    //  width: width * 0.85,
                                    // height: height*0.43,
                                  ),


                                ),

                                Positioned(

                                  top: 82,
                                  left: 94,

                                  child: buildBottomSegment('Sun', 'assets/images/p_sun.svg', 'assets/images/s_sun.svg',



                                      width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 220,

                                  top: 55,

                                  child: buildBottomSegment('Mercury', 'assets/images/p_mercury.svg', 'assets/images/s_mercury.svg',



                                      width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 164,

                                  top: 12,

                                  child: buildBottomSegment('Mars', 'assets/images/p_mars.svg', 'assets/images/s_mars.svg', top: 0, right: 35,width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 67,

                                  top: 221,

                                  child: buildBottomSegment('Saturn', 'assets/images/p_saturn.svg', 'assets/images/s_saturn.svg', top: 65, right: 38,width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 225,

                                  top: 161,

                                  child: buildBottomSegment('Jupiter', 'assets/images/p_jupitor.svg', 'assets/images/s_jupiter.svg', top: 39, right: 2,width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 14,

                                  top: 169,

                                  child: buildBottomSegment('Rahu', 'assets/images/p_rahu.svg', 'assets/images/s_rahu.svg', top: 48, right: 66,width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left:13,

                                  top: 63,

                                  child: buildBottomSegment('Ketu', 'assets/images/p_ketu.svg', 'assets/images/s_ketu.svg', top: 34, right: 65,width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 170,

                                  top: 217,

                                  child: buildBottomSegment('Venus', 'assets/images/p_venus.svg', 'assets/images/s_venus.svg', top: 66, right: 35,width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain),

                                ),

                                Positioned(

                                  left: 58,

                                  top: 12,

                                  child: buildBottomSegment('Moon', 'assets/images/p_moon.svg', 'assets/images/s_moon.svg', top: 7,

                                      width: svgWidth,

                                      height: svgHeight,

                                      fit: BoxFit.contain

                                      , right: 43),

                                ),

                              ],

                            ),

                          ),
                        ),
                        ),
                        SizedBox(height: height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height*0.08,
                              width: width*0.35,
                              child: ElevatedButton(
                                onPressed: _resetSelections,


                                style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                                  backgroundColor: MaterialStatePropertyAll(MyMateThemes.secondaryColor),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(width*0.01)
                                      )),

                                ),
                                child:  Text(
                                  "Edit",
                                  style: TextStyle(fontSize: width*0.05),
                                ),
                              ),
                            ),
                            SizedBox(width: width*0.04),
                            SizedBox(
                              height: height*0.08,
                              width: width*0.35,
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  if (_areAllSelectionsComplete()) {
                                    _storeSelections();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ViewNavamsaChartPage()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Please complete all selections before proceeding.'),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                                  backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(width*0.01)
                                      )),

                                ),
                                child:  Text(
                                  "Next",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: width*0.04),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],

                    ),

                  );



              },

            ),

          );
        }
    );

  }
}
