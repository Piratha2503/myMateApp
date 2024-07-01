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
            String res = RasimatchingFunction("Kadagam", "Kanni");
            print(res);
          }, child: Icon(Icons.confirmation_num), ),
        ),
    );
  }
}

String RasimatchingFunction(String girlRasi,String boyRasi){
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
    return YoniPoruthamFunction("Aayilyam", "pooram");
  }
}

String YoniPoruthamFunction(String girlNadchathiram,String boyNadchathiram){

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

String ThinaporuthamFunction(String girlNadchathiram,String boyNadchathiram ){
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