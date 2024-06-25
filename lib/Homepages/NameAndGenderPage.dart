import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/ChartOptions.dart';
import 'package:mymateapp/MyMateThemes.dart';

class NameAndGender extends StatefulWidget {

  const NameAndGender({super.key});

  @override
  State<NameAndGender> createState() => _NameAndGenderState();

}

class _NameAndGenderState extends State<NameAndGender> {
  String Gender = "";

  void onPressed() {
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>const ChartOptions()));
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
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                ),
                Container( height: 50,),
                SizedBox(
                  width: 300, // Set the width of the TextField
                  height: 50, // Set the height of the TextField
                  child: TextField(
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ),
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
                        foregroundColor: WidgetStatePropertyAll(Colors.indigo),
                        alignment: Alignment.center,
                        textStyle: WidgetStatePropertyAll(TextStyle(
                          fontWeight: FontWeight.w800
                        )),
                        iconSize: WidgetStatePropertyAll(70),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                        fixedSize: WidgetStatePropertyAll(Size(120, 120))
                      ),
                    ),
                    SizedBox(width: 50,),
                    ElevatedButton.icon(
                      onPressed: Changed,
                      label: const Text(""),
                      icon: Icon(Icons.female_outlined),
                      style: const ButtonStyle(
                       foregroundColor: WidgetStatePropertyAll(Colors.purple),
                          alignment: Alignment.center,
                          textStyle: WidgetStatePropertyAll(TextStyle(
                              fontWeight: FontWeight.w800,

                          )),
                          iconSize: WidgetStatePropertyAll(70),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                          fixedSize: WidgetStatePropertyAll(Size(120, 120))
                      ),
                    ),
                  ],

                ),
                const SizedBox(height: 65,),
                SizedBox(
                  height: 58,
                  width: 166,
                  child: ElevatedButton(onPressed: onPressed,
                    style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll(MyMateThemes.primaryColor),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                    ),
                    child: const Text(
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

InputDecoration MyInputDecorations(String hint){
  return InputDecoration(

    hintText: hint,
    hintStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 25,
    ),

  );
}
