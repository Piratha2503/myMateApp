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
    return YoniPoruthamFunction("Revathi", "pooraddaathi");
  }
}

String YoniPoruthamFunction(String girlNadchathiram,String boyNadchathiram){

  String boyAnimal = "";
  String girlAnimal = "";

  for (var yoni in RasiNadchathiram.YoniList) {
   if(boyNadchathiram == yoni["Nadchathra"]) boyAnimal = yoni["Animal"].toString();

   if(girlNadchathiram == yoni["Nadchathra"]) girlAnimal = yoni["Animal"].toString();

  }
  if(RasiNadchathiram.yoniMismatchList.contains([boyAnimal,girlAnimal])) {
    return "Yoni Mismatch";
  } else {
    return [boyAnimal,girlAnimal].toString();
  }
}