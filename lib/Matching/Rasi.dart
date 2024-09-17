import 'package:flutter/material.dart';
import 'package:mymateapp/Matching/RasiAndNadchathiram.dart';

class RasiPorutham extends StatefulWidget{
  const RasiPorutham({super.key});

  @override
  State<RasiPorutham> createState()=> _RasiPoruthamState();
}

class _RasiPoruthamState extends State<RasiPorutham>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: (){
            String res = _checkRasiMatch("Kadagam", "Kanni");
            print(res);
          }, child: Icon(Icons.confirmation_num), ),
        ),
    );
  }
}

String _checkRasiMatch(String girlRasi,String boyRasi){
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
    return "Rasi Not Matched";
  } else {
    return _checkYoniMatch("Aayilyam", "pooram");
  }
}

String _checkYoniMatch(String girlNadchathiram,String boyNadchathiram){

  String boyAnimal = "";
  String girlAnimal = "";
  String Resulst = "Matched";

  RasiNadchathiram.YoniList.forEach((yoni){
   if(boyNadchathiram == yoni["Nadchathra"]) {
      boyAnimal = yoni["Animal"].toString();
    }

    if(girlNadchathiram == yoni["Nadchathra"]) {
      girlAnimal = yoni["Animal"].toString();
    }
  });

  for(List<String>yoniMatch in RasiNadchathiram.yoniMismatchingList){
    if(yoniMatch[0] == boyAnimal && yoniMatch[1] == girlAnimal){
      Resulst = "Mis matched";
      break;
    }
    //print(yoniMatch.toString());
  }

  return Resulst;
}

String _checkThinaMatch(String girlNadchathiram,String boyNadchathiram ){
  int girlNadchathiraIndex = RasiNadchathiram.nadchathiraMatchList.indexOf(girlNadchathiram)+1;
  int boyNadchathiraIndex = RasiNadchathiram.nadchathiraMatchList.indexOf(boyNadchathiram)+1;
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
    return "Thina porutham Miss Matched";
  } else {
    return "Thina porutham Matched";
  }

}

String _checkKanaMatch(String boyStarName, String girlStarName) {

  String message = "";

    if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
      if ((RasiNadchathiram.Theva.contains(boyStarName) &&
          RasiNadchathiram.Theva.contains(girlStarName)) ||
          (RasiNadchathiram.Manusa.contains(boyStarName) &&
              RasiNadchathiram.Manusa.contains(girlStarName)) ||
          (RasiNadchathiram.Manusa.contains(boyStarName) &&
              RasiNadchathiram.Theva.contains(girlStarName))) {
        message = 'Matched';
      } else if ((RasiNadchathiram.Ratchasa.contains(boyStarName) &&
          RasiNadchathiram.Ratchasa.contains(girlStarName)) ||
          (RasiNadchathiram.Ratchasa.contains(boyStarName) &&
              RasiNadchathiram.Theva.contains(girlStarName)) ||
          (RasiNadchathiram.Ratchasa.contains(girlStarName)) ||
          (RasiNadchathiram.Theva.contains(boyStarName) &&
              RasiNadchathiram.Manusa.contains(girlStarName)) ||
          (RasiNadchathiram.Ratchasa.contains(boyStarName) &&
              RasiNadchathiram.Manusa.contains(girlStarName))) {
        message = 'Not Matched';
      } else {
        message = 'Error in entered name';
      }
    } else {
      message = 'Please enter both Star names';
    }

    return message;

}

String _checkRachuMatch(String boyStarName, String girlStarName) {
  String message = "";

  if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
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
      message = 'Not Matched';
    } else {
      message = 'Matched';
    }
  } else {
    message = 'Please enter both Star names';
  }
return message;
}

String _checkMatch(String boyRasiName, String girlRasiName) {

  String message = "";

  if (boyRasiName.isNotEmpty && girlRasiName.isNotEmpty) {
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
      message = 'Matched';
    } else {
      message = 'Not Matched';
    }
  } else {
    message = 'Please enter both Rasi names';
  }
  return message;
}

String _checkVethaiMatch(String boyStarName, String girlStarName) {
  String message = "";

  if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
    if (RasiNadchathiram.vethaiMismatchList.any((pair) =>
    pair.contains(boyStarName) && pair.contains(girlStarName))) {
      message = 'Not matched';
    } else {
      message = 'Matched';
    }
  } else {
    message = 'Please enter both Star names';
  }
  return message;
}

String _checkVirutshaMatch(String boyStarName, String girlStarName) {

  String message = "";

  if (boyStarName.isNotEmpty && girlStarName.isNotEmpty) {
    if ((RasiNadchathiram.Milk.contains(boyStarName) &&
        RasiNadchathiram.Milk.contains(girlStarName)) ||
        (RasiNadchathiram.Milk.contains(boyStarName) &&
            RasiNadchathiram.NonMilk.contains(girlStarName)) ||
        (RasiNadchathiram.NonMilk.contains(boyStarName) &&
            RasiNadchathiram.Milk.contains(girlStarName))) {
      message = 'Matched';
    } else {
      message = 'Not Matched';
    }
  } else {
    message = 'Please enter both Star names';
  }
  return message;
}

