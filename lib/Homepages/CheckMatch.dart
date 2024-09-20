import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Matching/PoruthamList.dart';
import 'package:mymateapp/Matching/Rasi.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'bottom_navigation_bar.dart';

final List<Map<String, String>> poruthamList = PoruthamList.poruthamList;

class CheckmatchPage extends StatefulWidget {
  const CheckmatchPage({super.key});

  @override
  State<CheckmatchPage> createState() => _CheckmatchPageState();
}

  class _CheckmatchPageState extends State<CheckmatchPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/images/chevron-left.svg'),
                ),
                SizedBox(width: 100),
                Text(
                  '@user240678',
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SvgPicture.asset('assets/images/Frame.svg',
                    width: 240, height: 160),
                Positioned(
                    top: 45,
                    right: 56,
                    child: Text(
                      '60%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),)
                ),
                Positioned(
                    top: 90,
                    right: 68,
                    child: Text(
                      'Match',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (poruthamList.length + 1) ~/
                    2, // Calculate the number of rows needed
                itemBuilder: (context, index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PoruthamColumn(poruthamList[firstIndex]),
                      SizedBox(width: 10),
                      if (secondIndex <
                          poruthamList.length) // Only add second if it exists
                        PoruthamColumn(poruthamList[secondIndex]),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

  Widget PoruthamColumn(Map<String, String> item) {
  return Column(
    children: [
      Container(
        width: 150,
        height: 60,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: item['status'] == 'true'
              ? MyMateThemes.primaryColor
              : MyMateThemes.secondaryColor,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              child: Text(
                item['name']!,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Positioned(
              top: 0,
              left: 20,
              child: Text(
                item['status']!,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            Positioned(
              top: 0,
              child: SvgPicture.asset(
                item['svg']!,
                // style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
        // Center(
        //   child:
        //   Text(
        //     item['name']!,
        //     style: TextStyle(color: Colors.white, fontSize: 16),
        //   ),
        // ),
      ),
    ],
  );
}