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
            height: 150,
            width: 400,
            child: ContainerColumn(),
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
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(25, 40, 78, 200)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
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
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  style: CommonButtonStyle.commonButtonStyle(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget BorderBox() {
  return Container(
    height: 70,
    width: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      border: Border.all(style: BorderStyle.solid),
    ),
  );
}

Widget NoBorderBox() {
  return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
      ));
}

Widget ChartImage() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox(),
          BorderBox(),
          BorderBox(),
          BorderBox(),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox(),
          NoBorderBox(),
          NoBorderBox(),
          BorderBox(),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox(),
          NoBorderBox(),
          NoBorderBox(),
          BorderBox(),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderBox(),
          BorderBox(),
          BorderBox(),
          BorderBox(),
        ],
      ),
    ],
  );
}

Widget ContainerColumn() {
  return const Column(
    children: [
      Text(
        "Enter birth details",
        style: TextStyle(
            fontSize: MyMateThemes.subHeadFontSize,
            color: MyMateThemes.textGray),
      ),
      Text(
        "to calculate Astrology chart ",
        style: TextStyle(
            fontSize: MyMateThemes.subHeadFontSize,
            color: MyMateThemes.textColor),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "Make sure this number can receive SMS.",
        style: TextStyle(fontSize: 14),
      ),
      Text(
        "You will receive your activation code",
        style: TextStyle(fontSize: 14),
      ),
      Text(
        "through it.",
        style: TextStyle(fontSize: 14),
      ),
    ],
  );
}
