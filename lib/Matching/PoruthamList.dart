import 'Rasi.dart';

class PoruthamList{

  String girlNadchathiram = "Kadagam";
  String boyNadchathiram = "Simmam";


  static final List<Map<String, String>> poruthamList = [
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Dina porutham',
      'status': MatchingCalculation.checkThinaMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Gana porutham',
      'status': "Matched"
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Stree Deergha porutham',
      'status': 'Not Satisfactory'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Mahendra porutham',
      'status': 'Good'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Yoni porutham',
      'status': MatchingCalculation.checkYoniMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Veda porutham',
      'status': 'Good'
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Rajju porutham',
      'status': 'Not Satisfactory'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Rasi porutham',
      'status': MatchingCalculation.checkRasiMatch(PoruthamList().girlNadchathiram, PoruthamList().boyNadchathiram).toString(),
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Rasiathipathy porutham',
      'status': 'Good'
    },
    {
      'svg': 'assets/images/blackcross.svg',
      'name': 'Vasya porutham',
      'status': 'Not Satisfactory'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Dina porutham',
      'status': 'Good'
    },
    {
      'svg': 'assets/images/whitetick.svg',
      'name': 'Mahendra porutham',
      'status': 'Good'
    },
  ];
}
