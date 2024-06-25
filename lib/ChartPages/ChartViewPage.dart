import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartInputPage.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ChartViewPage extends StatefulWidget {
  const ChartViewPage({super.key});

  @override
  State<ChartViewPage> createState() => _ChartViewPageState();
}

class _ChartViewPageState extends State<ChartViewPage> {
  void onPressed() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
      ),
      body: Column(
        children: [

          SizedBox(
            height: 25,
          ),
          ChartImage(),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(25, 40, 78, 200)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                  ),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: CommonButtonStyle.commonButtonStyle(),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget BorderBox(String planet,int position) {
  return Container(
    height: 70,
    width: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      border: Border.all(
        color: Colors.indigo,
          style: BorderStyle.solid),
    ),
    child: Column(
      children: [
        Text(position.toString()),
        SizedBox(height: 5,),
        Container(
          child: Center(
            child: Text(planet,style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),),
          ),
        ),
      ],
    )
  );
}

Widget NoBorderBox() {
  return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
  );
}

Widget ChartImage() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox("ல",1),
          BorderBox("சூரி",2),
          BorderBox("ரா",3),
          BorderBox("சந்",4),

        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox("சனி",5),
          NoBorderBox(),
          NoBorderBox(),
          BorderBox("குரு",6),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox("கே+சுக்",7),
          NoBorderBox(),
          NoBorderBox(),
          BorderBox("செவ்",8),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox("பு",9),
          BorderBox("குரு",10),
          BorderBox("",11),
          BorderBox("",12),
        ],
      ),
    ],
  );
}

Widget TitleContainer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(

      child: Text(
          "Your Astrology Chart",
          style: TextStyle(
            color: MyMateThemes.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
      ),
      ),
    ],
  );
}
