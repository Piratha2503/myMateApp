import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';

class RasiPorutham extends StatefulWidget {
  const RasiPorutham({super.key});

  @override
  State<RasiPorutham> createState() => _RasiPoruthamState();
}

class _RasiPoruthamState extends State<RasiPorutham> {

  CheckMatching clientData = CheckMatching(rasi: "Meenam", nadchathiram: "Revathi", isBoy: true);
  CheckMatching soulData = CheckMatching(rasi: "Kanni", nadchathiram: "Uththaram", isBoy: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: (){
            print(MatchingCalculation.checkTotalMatching(clientData, soulData));
          }, child: Icon(Icons.confirmation_num), ),
        ),
    );
  }
}

class MatchingCalculation{

  static String checkTotalMatching(CheckMatching clientData, CheckMatching soulData){

    bool isBoy = clientData.isBoy;
    String boy_nadchathiram = isBoy ? clientData.nadchathiram : soulData.nadchathiram;
    String boy_rasi = isBoy ? clientData.rasi : soulData.rasi;
    String girl_nadchathiram = isBoy ? soulData.nadchathiram : clientData.nadchathiram;
    String girl_rasi = isBoy ? soulData.nadchathiram : clientData.nadchathiram;

    int match = 3;
    String output_result = (match*10).toString()+"%";
    if(check_rachchu_vethai_yoni(boy_nadchathiram, girl_nadchathiram)){
      if(check_thina_kana_vashya(boy_nadchathiram, boy_rasi, girl_nadchathiram, girl_rasi)){

        if(checkRasiMatch(boy_rasi, girl_rasi)){match += 1; output_result = (match * 10).toString() + "%";}
        if(checkKanaMatch(boy_nadchathiram, girl_nadchathiram)) {match += 1; output_result = (match * 10).toString() + "%";}


        if(checkThinaMatch(boy_nadchathiram, girl_nadchathiram)) {match += 1;output_result = (match * 10).toString() + "%";}
        if(checkVasyaMatch(boy_rasi, girl_rasi)) {match += 1; output_result = (match * 10).toString() + "%";}
        if(checkVirutshaMatch(boy_nadchathiram, girl_nadchathiram)){match += 1; output_result = (match * 10).toString() + "%";}

      }
      else {
        output_result = "not_matched";
      }

    }
    else {
      output_result = "not_matched";
    }
    return output_result;
  }

  static bool check_rachchu_vethai_yoni(String boy_nadchathiram,String girl_nadchathiram){

    if(checkRachuMatch(boy_nadchathiram, girl_nadchathiram) &&
        checkVethaiMatch(boy_nadchathiram, girl_nadchathiram) &&
        checkYoniMatch(girl_nadchathiram, boy_nadchathiram)){
      return true;
    }
    else {
      return false;
    }

  }

  static bool check_thina_kana_vashya(String boy_nadchathiram, String boy_rasi,String girl_nadchathiram, String girl_rasi){

    if(checkThinaMatch(girl_nadchathiram, boy_nadchathiram) ||
        checkKanaMatch(boy_nadchathiram, girl_nadchathiram) ||
        checkVasyaMatch(boy_rasi, girl_rasi)){
      return true;
    }
    else {
      return false;
    }
  }

  static bool checkRasiMatch(String boy_rasi,String girl_rasi) {
    int girlRasiIndex = RasiNadchathiram.rasiListOrder.indexOf(girl_rasi)+1;
    int boyRasiIndex = RasiNadchathiram.rasiListOrder.indexOf(boy_rasi) +1;
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

  static bool checkYoniMatch(String boy_nadchathiram,String girl_nadchathiram) {

    String boyAnimal = "";
    String girlAnimal = "";
    bool Resulst = true;

    for (var yoni in RasiNadchathiram.YoniList) {
      if(boy_nadchathiram == yoni["Nadchathra"]) {
        boyAnimal = yoni["Animal"].toString();
      }

      if(girl_nadchathiram == yoni["Nadchathra"]) {
        girlAnimal = yoni["Animal"].toString();
      }
    }

    for(List<String>yoniMatch in RasiNadchathiram.yoniMismatchList){
      if(yoniMatch[0] == boyAnimal && yoniMatch[1] == girlAnimal){
        Resulst = false;
        break;
      }

    }

    return Resulst;
  }

  static bool checkThinaMatch(String boy_nadchathiram,String girl_nadchathiram) {
    int girlNadchathiraIndex = RasiNadchathiram.nadchathiraList.indexOf(girl_nadchathiram)+1;
    int boyNadchathiraIndex = RasiNadchathiram.nadchathiraList.indexOf(boy_nadchathiram)+1;
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

  static bool checkKanaMatch(String boy_nadchathiram, String girl_nadchathiram) {

    if(RasiNadchathiram.Ratchasa.contains(girl_nadchathiram)) {
      return false;
    }
    else{
     if(RasiNadchathiram.Theva.contains(boy_nadchathiram) && (RasiNadchathiram.Theva.contains(girl_nadchathiram)||RasiNadchathiram.Manusa.contains(girl_nadchathiram))) {
       return true;
     }
     else if(RasiNadchathiram.Manusa.contains(boy_nadchathiram) && RasiNadchathiram.Theva.contains(girl_nadchathiram)||RasiNadchathiram.Manusa.contains(girl_nadchathiram)) {
       return true;

     }
     else if(RasiNadchathiram.Ratchasa.contains(boy_nadchathiram) && RasiNadchathiram.Manusa.contains(girl_nadchathiram)) return true;
     else{
       return false;
     }
    }
  }

  static bool checkRachuMatch(String boy_nadchathiram, String girl_nadchathiram) {
    String boyStarName = boy_nadchathiram;
    String girlStarName = girl_nadchathiram;

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

  static bool checkVasyaMatch(String boy_rasi, String girl_rasi) {
    String boyRasiName = boy_rasi;
    String girlRasiName = girl_rasi;

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

  static bool checkVethaiMatch(String boy_nadchathiram, String girl_nadchathiram) {

    if (RasiNadchathiram.vethaiMismatchList.any(
        (pair) => pair.contains(boy_nadchathiram) && pair.contains(girl_nadchathiram))) {
      return false;
    }
    return true;
  }

  static bool checkVirutshaMatch(String boy_nadchathiram, String girl_nadchathiram) {


    if ((RasiNadchathiram.Milk.contains(boy_nadchathiram) &&
            RasiNadchathiram.Milk.contains(girl_nadchathiram)) ||
        (RasiNadchathiram.Milk.contains(boy_nadchathiram) &&
            RasiNadchathiram.NonMilk.contains(girl_nadchathiram)) ||
        (RasiNadchathiram.NonMilk.contains(boy_nadchathiram) &&
            RasiNadchathiram.Milk.contains(girl_nadchathiram))) {
      return true;
    }
    return false;
  }
}

class CheckMatching{
  String rasi;
  String nadchathiram;
  bool isBoy;

  CheckMatching({
    required this.rasi,
    required this.nadchathiram,
    required this.isBoy
  });

}
