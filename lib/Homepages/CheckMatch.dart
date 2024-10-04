import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Matching/Rasi.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../dbConnection/Firebase.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';

class CheckmatchPage extends StatefulWidget {
  const CheckmatchPage({super.key});

  @override
  State<CheckmatchPage> createState() => _CheckmatchPageState();

}

  class _CheckmatchPageState extends State<CheckmatchPage> {

    final Firebase firebase = Firebase();

  int _selectedIndex = 0;
    String girlNadchathiram = "Bharani";
    String boyNadchathiram = "Pusham";
    String girlRasi = "Kadagam";
    String boyRasi = "Kanni";
    String user = "TestUser";

  Future<void> getGirlClient() async{
    String docId = "EuzvIHpObxhHjOo9iutc";
    DocumentSnapshot client = await firebase.clients.doc(docId).get();
    setState(() {
      boyNadchathiram = client["Nadchathiram"];
      boyRasi = client["Rasi"];
      user = client["full_name"];
    });
  }

  @override
  void initState(){
    super.initState();
    getGirlClient();
  }

    static final List<Map<String, String>> poruthamList = [
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Dina porutham',
        'status': MatchingCalculation.checkThinaMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram).toString(),
      },
      {
        'svg': 'assets/images/blackcross.svg',
        'name': 'Gana porutham',
        'status': MatchingCalculation.checkKanaMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram).toString()
      },
      {
        'svg': 'assets/images/blackcross.svg',
        'name': 'Stree Deergha porutham',
        'status': 'Not Satisfactory'
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Mahendra porutham 1',
        'status': 'Good'
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Yoni porutham',
        'status': MatchingCalculation.checkYoniMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram).toString(),
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Veda porutham',
        'status': MatchingCalculation.checkVethaiMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram).toString(),
      },
      {
        'svg': 'assets/images/blackcross.svg',
        'name': 'Rajju porutham',
        'status': MatchingCalculation.checkRachuMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram).toString(),
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Rasi porutham',
        'status': MatchingCalculation.checkRasiMatch(_CheckmatchPageState().girlRasi, _CheckmatchPageState().boyRasi).toString(),
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Rasiathipathy porutham',
        'status': 'Good'
      },
      {
        'svg': 'assets/images/blackcross.svg',
        'name': 'Vasya porutham',
        'status': MatchingCalculation.checkVasyaMatch(_CheckmatchPageState().girlRasi, _CheckmatchPageState().boyRasi).toString(),
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Dina porutham',
        'status': MatchingCalculation.checkThinaMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram).toString(),
      },
      {
        'svg': 'assets/images/whitetick.svg',
        'name': 'Mahendra porutham 2',
        'status': 'Good'
      },
    ];


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
                  user,
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

      ),
    ],
  );
}