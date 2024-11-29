import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/GenerateChart.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Clients.dart';

class ChartOptions extends StatefulWidget{
  TestClient clientProfile;
  ChartOptions({super.key, required this.clientProfile});

  @override
  State<ChartOptions> createState() => _ChartOptionsState();
}

class _ChartOptionsState extends State<ChartOptions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                ChartOptionsTexts(),
                GenerateChartOption(),
                SizedBox(height: 50),
                Divider(height: 5),
                SizedBox(height: 50),
                ManualChartOption(),
              ],
            ),
          )),
    );
  }

}

Widget ChartOptionsTexts(){
  return  Flex(
    direction: Axis.vertical,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text( "Choose Preferred",
        style: TextStyle( fontSize: MyMateThemes.nomalFontSize, ),
      ),
      SizedBox(height: 10),
      Text( "Astrology chart input method",
        style: TextStyle(
            fontSize: MyMateThemes.subHeadFontSize,
            color: MyMateThemes.textColor
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text("You can generate astrology chart with required "
            "birth details or you can enter manually"),
      ),
      SizedBox(height: 30),
    ],
  );
}

class GenerateChartOption extends StatelessWidget {
  void onTab(BuildContext context){
    print("Hello");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GenerateChart()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTab(context);
      },
      child: Container(
        height: 125,
        width: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyMateThemes.secondaryColor,
              spreadRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.table_chart,
              size: 50,
              color: MyMateThemes.textColor,

            ),
            SizedBox(height: 10,),
            Text(
              "Generate the chart",

              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: MyMateThemes.textGray),
            )
          ],
        ),
      ),
    );
  }



}

class ManualChartOption extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(

        height: 125,
        width: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyMateThemes.secondaryColor,
              spreadRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ads_click,
              size: 50,
              color: MyMateThemes.textColor,
            ),
            SizedBox( height: 10, ),
            Text(
              "Enter chart manually",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: MyMateThemes.textGray),
            )
          ],
        ),
      ),
    );
  }

}
