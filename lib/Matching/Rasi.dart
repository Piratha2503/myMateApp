import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';

class RasiPorutham extends StatefulWidget {
  const RasiPorutham({super.key});

  @override
  State<RasiPorutham> createState() => _RasiPoruthamState();
}

class _RasiPoruthamState extends State<RasiPorutham> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: (){
            bool res = MatchingCalculation.checkRasiMatch("Kadagam", "Simmam");
            print(res);
          }, child: Icon(Icons.confirmation_num), ),
        ),
    );
  }
}

class MatchingCalculation{

  static bool checkRasiMatch(String girlRasi,String boyRasi) {
    int girlRasiIndex = RasiNadchathiram.rasiListOrder.indexOf(girlRasi)+1;
    int boyRasiIndex = RasiNadchathiram.rasiListOrder.indexOf(boyRasi) +1;
    int RasiMatchNumber = 0;

    if(girlRasiIndex < boyRasiIndex) {
      RasiMatchNumber = boyRasiIndex - girlRasiIndex + 1;
      print("Boy :- $boyRasiIndex + girl :- $girlRasiIndex == $RasiMatchNumber");
    }
    else{
      RasiMatchNumber = (12-girlRasiIndex) + boyRasiIndex + 1 ;
      print("Boy :- $boyRasiIndex + girl :- $girlRasiIndex == $RasiMatchNumber");

    }

    if(RasiNadchathiram.rasiMatchNumberList.contains(RasiMatchNumber)) {
      return false;
    } else {
      return true;
    }
  }

  static bool checkYoniMatch(String girlNadchathiram,String boyNadchathiram) {

    String boyAnimal = "";
    String girlAnimal = "";
    bool Resulst = true;

    RasiNadchathiram.YoniList.forEach((yoni){
      if(boyNadchathiram == yoni["Nadchathra"]) {
        boyAnimal = yoni["Animal"].toString();
      }

      if(girlNadchathiram == yoni["Nadchathra"]) {
        girlAnimal = yoni["Animal"].toString();
      }
    });

    for(List<String>yoniMatch in RasiNadchathiram.yoniMismatchList){
      if(yoniMatch[0] == boyAnimal && yoniMatch[1] == girlAnimal){
        Resulst = false;
        break;
      }

    }

    return Resulst;
  }

  static bool checkThinaMatch(String girlNadchathiram,String boyNadchathiram ) {
    int girlNadchathiraIndex = RasiNadchathiram.nadchathiraList.indexOf(girlNadchathiram)+1;
    int boyNadchathiraIndex = RasiNadchathiram.nadchathiraList.indexOf(boyNadchathiram)+1;
    int nadchathiraMatchNumber = 0;

    if(girlNadchathiraIndex < boyNadchathiraIndex) {
      nadchathiraMatchNumber = boyNadchathiraIndex - girlNadchathiraIndex + 1;
      print("Boy :- $boyNadchathiraIndex + girl :- $girlNadchathiraIndex == $nadchathiraMatchNumber");
    }
    else{
      nadchathiraMatchNumber = (27-girlNadchathiraIndex) + boyNadchathiraIndex + 1 ;
      print("Boy :- $boyNadchathiraIndex + girl :- $girlNadchathiraIndex == $nadchathiraMatchNumber");

    }

    if(nadchathiraMatchNumber % 2 == 1) {
      return false;
    } else {
      return true;
    }
  }

  static bool checkKanaMatch(String boyStarName, String girlStarName) {

    if ((RasiNadchathiram.Theva.contains(boyStarName) &&
            RasiNadchathiram.Theva.contains(girlStarName)) ||
        (RasiNadchathiram.Manusa.contains(boyStarName) &&
            RasiNadchathiram.Manusa.contains(girlStarName)) ||
        (RasiNadchathiram.Manusa.contains(boyStarName) &&
            RasiNadchathiram.Theva.contains(girlStarName))) {
      return true;
    }
    return false;
  }

  static bool checkRachuMatch(String boyStarName, String girlStarName) {
    // String boyStarName = '';
    // String girlStarName = '';
    // bool isMatched = false;

    if ((RasiNadchathiram.Group1.contains(boyStarName) &&
            RasiNadchathiram.Group1.contains(girlStarName)) ||
        (RasiNadchathiram.Group2.contains(boyStarName) &&
            RasiNadchathiram.Group2.contains(girlStarName)) ||
        (RasiNadchathiram.Group3.contains(boyStarName) &&
            RasiNadchathiram.Group3.contains(girlStarName)) ||
        (RasiNadchathiram.Group4.contains(boyStarName) &&
            RasiNadchathiram.Group4.contains(girlStarName)) ||
        (RasiNadchathiram.Group5.contains(boyStarName) &&
            RasiNadchathiram.Group5.contains(girlStarName))) {
      return false;
    }
    return true;
  }

  static bool checkVasyaMatch(String boyRasiName, String girlRasiName) {
    // String boyRasiName = '';
    // String girlRasiName = '';
    // bool isMatched = false;

    if (girlRasiName == 'Mesham' &&
            (boyRasiName == 'Simmam' || boyRasiName == 'Viruchigam') ||
        girlRasiName == 'Rishabam' &&
            (boyRasiName == 'Kadagam' || boyRasiName == 'Thulam') ||
        girlRasiName == 'Mithunam' && (boyRasiName == 'Kanni') ||
        girlRasiName == 'Kadagam' &&
            (boyRasiName == 'Viruchigam' || boyRasiName == 'Thanusu') ||
        girlRasiName == 'Simmam' && (boyRasiName == 'Magaram') ||
        girlRasiName == 'Kanni' &&
            (boyRasiName == 'Rishabam' || boyRasiName == 'Meenam') ||
        girlRasiName == 'Thulam' && (boyRasiName == 'Magaram') ||
        girlRasiName == 'Viruchigam' &&
            (boyRasiName == 'Kadagam' || boyRasiName == 'Kanni') ||
        girlRasiName == 'Thanusu' && (boyRasiName == 'Meenam') ||
        girlRasiName == 'Magaram' && (boyRasiName == 'Kumbam') ||
        girlRasiName == 'Kumbam' && (boyRasiName == 'Meenam') ||
        girlRasiName == 'Meenam' && (boyRasiName == 'Magaram')) {
      return true;
    }
    return false;
  }

  static bool checkVethaiMatch(String boyStarName, String girlStarName) {
    // String boyStarName = '';
    // String girlStarName = '';
    // bool isMatched = false;

    if (RasiNadchathiram.vethaiMismatchList.any(
        (pair) => pair.contains(boyStarName) && pair.contains(girlStarName))) {
      return false;
    }
    return true;
  }

  static bool checkVirutshaMatch(String boyStarName, String girlStarName) {
    // String boyStarName = '';
    // String girlStarName = '';
    // bool isMatched = false;

    if ((RasiNadchathiram.Milk.contains(boyStarName) &&
            RasiNadchathiram.Milk.contains(girlStarName)) ||
        (RasiNadchathiram.Milk.contains(boyStarName) &&
            RasiNadchathiram.NonMilk.contains(girlStarName)) ||
        (RasiNadchathiram.NonMilk.contains(boyStarName) &&
            RasiNadchathiram.Milk.contains(girlStarName))) {
      return true;
    }
    return false;
  }
}
