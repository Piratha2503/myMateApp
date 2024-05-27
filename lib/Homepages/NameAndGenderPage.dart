import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mymateapp/MyMateThemes.dart';

class NameAndGender extends StatefulWidget {
  const NameAndGender({super.key});

  @override
  State<NameAndGender> createState() => _NameAndGenderState();
}

class _NameAndGenderState extends State<NameAndGender> {
  String Gender = "";
  void onPressed() {
    print("object");
  }

  void Changed() {
    setState(() {
      Gender = "Male";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                SizedBox(
                  width: 300, // Set the width of the TextField
                  height: 50, // Set the height of the TextField
                  child: TextField(
                    decoration: MyInputDecorations("First name"),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
                SizedBox(
                  width: 300, // Set the width of the TextField
                  height: 50, // Set the height of the TextField
                  child: TextField(
                    decoration: MyInputDecorations("Last name"),
                  ),
                ),
                Container(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: Changed,
                      label: const Text(""),
                      icon: Icon(Icons.male_rounded),
                      style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.indigo),
                          alignment: Alignment.center,
                          textStyle: MaterialStatePropertyAll(
                              TextStyle(fontWeight: FontWeight.w800)),
                          iconSize: MaterialStatePropertyAll(70),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder()),
                          fixedSize: MaterialStatePropertyAll(Size(120, 120))),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton.icon(
                      onPressed: Changed,
                      label: const Text(""),
                      icon: Icon(Icons.female_outlined),
                      style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                          alignment: Alignment.center,
                          textStyle: MaterialStatePropertyAll(TextStyle(
                            fontWeight: FontWeight.w800,
                          )),
                          iconSize: MaterialStatePropertyAll(70),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder()),
                          fixedSize: MaterialStatePropertyAll(Size(120, 120))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 65,
                ),
                SizedBox(
                  height: 58,
                  width: 166,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      backgroundColor:
                          MaterialStatePropertyAll(MyMateThemes.primaryColor),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class MyInputDecorations extends InputDecoration {
  final String myHint;

  MyInputDecorations(this.myHint);
  @override
  // TODO: implement hintText
  String? get hintText => myHint;

  @override
  // TODO: implement hintStyle
  TextStyle? get hintStyle => const TextStyle(
        fontSize: 28,
        fontFamily: "Work Sans",
      );
}
