import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/ChartPages/ManualNavamsaChartPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/ClientDatabase.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';

import '../MyMateCommonBodies/MyMateApis.dart';

class ManualRasiChartPage extends StatefulWidget {
  ClientData clientData;
  ManualRasiChartPage({required this.clientData, super.key});

  @override
  State<ManualRasiChartPage> createState() => _ManualRasiChartPage();
}

class _ManualRasiChartPage extends State<ManualRasiChartPage> {
  Map<String, int> segmentToBoxMap = {};
  int? selectedTopBox;

  bool isSegmentSelected(String segment) => segmentToBoxMap.containsKey(segment);

  int? getSegmentBadge(String segment) => segmentToBoxMap[segment];

  void _onTapTopBox(int boxNumber) {
    setState(() => selectedTopBox = boxNumber);
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
  }

  Future<void> _storeSelections() async {
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
      switch (element.value) {
        case 1: option1List.add(element.key); break;
        case 2: option2List.add(element.key); break;
        case 3: option3List.add(element.key); break;
        case 4: option4List.add(element.key); break;
        case 5: option5List.add(element.key); break;
        case 6: option6List.add(element.key); break;
        case 7: option7List.add(element.key); break;
        case 8: option8List.add(element.key); break;
        case 9: option9List.add(element.key); break;
        case 10: option10List.add(element.key); break;
        case 11: option11List.add(element.key); break;
        case 12: option12List.add(element.key); break;
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

    print("📤 JSON Data: ${jsonEncode(widget.clientData.toMap())}");

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManualNavamsaChartPage(
          clientData: widget.clientData,
          astrology: astrology,
        ),
      ),
    );
  }
  void _resetSelections() {
    setState(() {
      segmentToBoxMap.clear();
      selectedTopBox = null;
    });
  }

  bool _areAllSelectionsComplete() {
    List<String> requiredSegments = ['Sun', 'Mercury', 'Mars', 'Saturn', 'Jupiter', 'Rahu', 'Ketu', 'Venus', 'Moon'];
    return requiredSegments.every((segment) => segmentToBoxMap.containsKey(segment));
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

    return Scaffold(

      backgroundColor: Colors.white,

      body: LayoutBuilder(

        builder: (context, constraints) {

          double containerWidth = constraints.maxWidth * 0.87;
          double containerHeight = constraints.maxHeight * 0.4;
          double svgWidth = containerWidth * 0.5;
          double svgHeight = containerHeight * 0.5;

          return
            Center(
              child: Column(
                children: [
                  SafeArea(
                    child:
                    Column(
                      children: [
                        Text(
                          "Enter Chart Rasi",
                          style: TextStyle(
                            color: MyMateThemes.textColor,
                            fontSize: containerHeight*0.075,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,

                          ),

                        ),

                        Text(
                          "to calculate Astrology Chart",
                          style: TextStyle(
                            color: MyMateThemes.primaryColor,
                            fontSize: containerHeight*0.075,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,

                          ),

                        ),

                      ],

                    ),

                  ),
                  SizedBox(height: containerHeight*0.01),
                  Container(

                    width: containerWidth*0.7,

                    height: containerHeight*0.6,

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius: BorderRadius.circular(containerWidth*0.02),

                    ),

                    child: GridView.count(

                      crossAxisCount: constraints.maxWidth > 600 ? 6 : 4,

                      childAspectRatio: containerWidth / (containerHeight * 1), crossAxisSpacing: containerWidth * 0.02,

                      mainAxisSpacing: containerHeight * 0.03,

                      padding: EdgeInsets.all(containerWidth*0.001),

                      children: List.generate(12, (index) => buildTopBox(index + 1, '${index + 1}')),

                    ),

                  ),
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

                        alignment: Alignment.center,

                        children: [

                          Positioned(

                            top: 75,

                            left: 88,

                            child: buildBottomSegment('Sun', 'assets/images/p_sun.svg', 'assets/images/s_sun.svg',



                                width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 212,

                            top: 46,

                            child: buildBottomSegment('Mercury', 'assets/images/p_mercury.svg', 'assets/images/s_mercury.svg',



                                width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 153,

                            top: 5,

                            child: buildBottomSegment('Mars', 'assets/images/p_mars.svg', 'assets/images/s_mars.svg', top: 0, right: 35,width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 60,

                            top: 212,

                            child: buildBottomSegment('Saturn', 'assets/images/p_saturn.svg', 'assets/images/s_saturn.svg', top: 65, right: 38,width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 215,

                            top: 150,

                            child: buildBottomSegment('Jupiter', 'assets/images/p_jupitor.svg', 'assets/images/s_jupiter.svg', top: 39, right: 2,width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 8,

                            top: 162,

                            child: buildBottomSegment('Rahu', 'assets/images/p_rahu.svg', 'assets/images/s_rahu.svg', top: 48, right: 66,width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left:4,

                            top: 58,

                            child: buildBottomSegment('Ketu', 'assets/images/p_ketu.svg', 'assets/images/s_ketu.svg', top: 34, right: 65,width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 163,

                            top: 207,

                            child: buildBottomSegment('Venus', 'assets/images/p_venus.svg', 'assets/images/s_venus.svg', top: 66, right: 35,width: svgWidth,

                                height: svgHeight,

                                fit: BoxFit.contain),

                          ),

                          Positioned(

                            left: 47,

                            top: 7,

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
                  SizedBox(height: containerHeight*0.1),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      GestureDetector(

                        onTap: _resetSelections,

                        child: SvgPicture.asset('assets/images/Clear.svg',

                          width: containerHeight*0.5,

                          height: containerHeight*0.2,),

                      ),

                      SizedBox( width: MediaQuery.of(context).size.width*0.05,

                      ),

                      GestureDetector(

                        onTap: () {

                          if (_areAllSelectionsComplete()) {

// Navigate to next page
                            _storeSelections();
                          } else {

                            ScaffoldMessenger.of(context).showSnackBar(

                              SnackBar(content: Text('Please complete all selections before proceeding.')),

                            );

                          }

                        },

                        child: SvgPicture.asset('assets/images/can.svg', width: containerHeight*0.5,

                          height: containerHeight*0.2,),

                      ),

                    ],

                  ),
                  SizedBox(height: containerHeight*0.01),
                ],

              ),

            );



        },

      ),

    );

  }
}