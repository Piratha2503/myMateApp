import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/Matching/Rasi.dart';
import 'package:mymateapp/MyMateThemes.dart';
import '../dbConnection/Firebase.dart';
import '../MyMateCommonBodies/MyMateBottomBar.dart';

class CheckmatchPage extends StatefulWidget {
  final String docId;
  const CheckmatchPage({required this.docId,super.key});

  @override
  State<CheckmatchPage> createState() => _CheckmatchPageState();

}

  class _CheckmatchPageState extends State<CheckmatchPage> {

    final Firebase firebase = Firebase();

    int _selectedIndex = 0;
    String girlNadchathiram = "Bharani";
    String boyNadchathiram = "";
    String girlRasi = "Kadagam";
    String boyRasi = "";
    String user = "TestUser";

  Future<void> getGirlClient() async{
    DocumentSnapshot client = await firebase.clients.doc(widget.docId).get();
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

    static bool thinaMatch = MatchingCalculation.checkThinaMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram);
    static bool kanaMatch = MatchingCalculation.checkKanaMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram);
    static bool yoniMatch  = MatchingCalculation.checkYoniMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram);
    static bool vethaiMatch = MatchingCalculation.checkVethaiMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram);
    static bool ratchuMatch = MatchingCalculation.checkRachuMatch(_CheckmatchPageState().girlNadchathiram, _CheckmatchPageState().boyNadchathiram);
    static bool rasiMatch = MatchingCalculation.checkRasiMatch(_CheckmatchPageState().girlRasi, _CheckmatchPageState().boyRasi);
    static bool vasyaMatch = MatchingCalculation.checkVasyaMatch(_CheckmatchPageState().girlRasi, _CheckmatchPageState().boyRasi);

    static bool streeThirgaMatch = false;
    static bool rasiAthipathiMatch = false;
    static bool mahendraMatch = false;

    static final List<Map<String, String>> poruthamList = [
      {
        'svg': thinaMatch ? 'assets/images/whitetick.svg' : 'assets/images/blackcross.svg',
        'name': 'Dina porutham',
        'status': thinaMatch.toString(),
      },
      {
        'svg': kanaMatch ? 'assets/images/whitetick.svg' : 'assets/images/blackcross.svg',
        'name': 'Gana porutham',
        'status': kanaMatch.toString()
      },
      {
        'svg': streeThirgaMatch ? 'assets/images/whitetick.svg' : 'assets/images/blackcross.svg',
        'name': 'Stree Deergha porutham',
        'status': streeThirgaMatch.toString()
      },
      {
        'svg': mahendraMatch ? 'assets/images/whitetick.svg' : 'assets/images/blackcross.svg',
        'name': 'Mahendra porutham 1',
        'status': mahendraMatch.toString()
      },
      {
        'svg': yoniMatch ? 'assets/images/whitetick.svg' : 'assets/images/blackcross.svg',
        'name': 'Yoni porutham',
        'status': yoniMatch.toString()
      },
      {
        'svg': vethaiMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Veda porutham',
        'status': vethaiMatch.toString()
      },
      {
        'svg': ratchuMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Rajju porutham',
        'status': ratchuMatch.toString()
      },
      {
        'svg': rasiMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Rasi porutham',
        'status': rasiMatch.toString()
      },
      {
        'svg': rasiAthipathiMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Rasiathipathy porutham',
        'status': rasiAthipathiMatch.toString()
      },
      {
        'svg': vasyaMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Vasya porutham',
        'status': vasyaMatch.toString()
      },
      {
        'svg': thinaMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Dina porutham',
        'status': thinaMatch.toString()
      },
      {
        'svg': mahendraMatch ? 'assets/images/whitetick.svg' :'assets/images/blackcross.svg',
        'name': 'Mahendra porutham 2',
        'status': mahendraMatch.toString()
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
          color: item['status'] == "true" ? MyMateThemes.primaryColor : MyMateThemes.secondaryColor,
          borderRadius: BorderRadius.circular(10),),
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