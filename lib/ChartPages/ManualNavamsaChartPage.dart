import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ManualNavamsaChartPage extends StatefulWidget {
  const ManualNavamsaChartPage({Key? key}) : super(key: key);

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
          !(tapped[button] ?? false); // Provide a default value if null
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

  void _storeSelections() {
    // Implement the logic to store selections as needed
    print('Selections stored: $segmentToBoxMap');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter Chart Navamsa",
                  style: TextStyle(
                      color: MyMateThemes.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "to calculate Astrology Chart",
                style: TextStyle(
                    color: MyMateThemes.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 310,
                height: 208,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(1),
                          child: Opacity(
                            opacity: (selectedTopBox == 1) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/one.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(2),
                          child: Opacity(
                            opacity: (selectedTopBox == 2) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/two.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(3),
                          child: Opacity(
                            opacity: (selectedTopBox == 3) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/three.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(4),
                          child: Opacity(
                            opacity: (selectedTopBox == 4) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/four.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(5),
                          child: Opacity(
                            opacity: (selectedTopBox == 5) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/five.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(6),
                          child: Opacity(
                            opacity: (selectedTopBox == 6) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/six.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(7),
                          child: Opacity(
                            opacity: (selectedTopBox == 7) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/seven.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(8),
                          child: Opacity(
                            opacity: (selectedTopBox == 8) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/eight.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(9),
                          child: Opacity(
                            opacity: (selectedTopBox == 9) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/nine.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(10),
                          child: Opacity(
                            opacity: (selectedTopBox == 10) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/ten.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(11),
                          child: Opacity(
                            opacity: (selectedTopBox == 11) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/eleven.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _onTapTopBox(12),
                          child: Opacity(
                            opacity: (selectedTopBox == 12) ? 1.0 : 0.6,
                            child: SvgPicture.asset('assets/images/twelve.svg'),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 400,
            width: 300,
            child: Stack(
              children: [
                Positioned(
                  top: 110,
                  left: 80,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Sun'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Sun') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Sun.svg'),
                        ),
                        if (getSegmentBadge('Sun') != null)
                          Positioned(
                            top: 10,
                            right: 15,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Sun').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 207,
                  top: 74,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Mercury'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Mercury') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Mercury.svg'),
                        ),
                        if (getSegmentBadge('Mercury') != null)
                          Positioned(
                            top: 27,
                            right: -2,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Mercury').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 152,
                  top: 30,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Mars'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Mars') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Mars.svg'),
                        ),
                        if (getSegmentBadge('Mars') != null)
                          Positioned(
                            top: 0,
                            right: 30,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Mars').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 55,
                  top: 245,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Saturn'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Saturn') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Saturn.svg'),
                        ),
                        if (getSegmentBadge('Saturn') != null)
                          Positioned(
                            top: 61,
                            right: 38,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Saturn').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 213,
                  top: 178,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Jupiter'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Jupiter') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Jupiter.svg'),
                        ),
                        if (getSegmentBadge('Jupiter') != null)
                          Positioned(
                            top: 40,
                            right: 3,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Jupiter').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 185,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Rahu'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Rahu') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Rahu.svg'),
                        ),
                        if (getSegmentBadge('Rahu') != null)
                          Positioned(
                            top: 40,
                            right: 65,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Rahu').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 82,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Ketu'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Ketu') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Ketu.svg'),
                        ),
                        if (getSegmentBadge('Ketu') != null)
                          Positioned(
                            top: 30,
                            right: 64,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Ketu').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 159,
                  top: 239,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Venus'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Venus') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Venus.svg'),
                        ),
                        if (getSegmentBadge('Venus') != null)
                          Positioned(
                            top: 65,
                            right: 28,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Venus').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 47,
                  top: 30,
                  child: GestureDetector(
                    onTap: () => _onTapBottomSegment('Moon'),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: isSegmentSelected('Moon') ? 0.7 : 1.0,
                          child: SvgPicture.asset('assets/images/Moon.svg'),
                        ),
                        if (getSegmentBadge('Moon') != null)
                          Positioned(
                            top: -2,
                            right: 50,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: MyMateThemes.premiumAccent,
                              child: Text(
                                getSegmentBadge('Moon').toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _resetSelections();
                },
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
                              'Please complete all selections before proceeding.')),
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
