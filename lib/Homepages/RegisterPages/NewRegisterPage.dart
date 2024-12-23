import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mymateapp/MyMateThemes.dart';

class NewRegisterPage extends StatefulWidget {
  const NewRegisterPage({super.key});

  @override
  State<NewRegisterPage> createState() => _NewRegisterPageState();
}

class _NewRegisterPageState extends State<NewRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Column(
              children: <Widget>[
                Text(
                  "Start register",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: MyMateThemes.primaryColor
                  ),
                ),
                Text(
                  "with your phone number",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w500,
                      color: MyMateThemes.primaryColor
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/screenDesign/dating.png",width: 275,height: 275,),
                  ],
                ),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: MyMateThemes.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Light black shadow
                        offset: Offset(0, -4), // Negative Y offset for shadow above
                        blurRadius: 10, // Soft blur
                        spreadRadius: 2, // Slight spread for a subtle shadow
                      ),
                    ],
                  ),
                  child: Column(

                    children: [
                      Padding(
                        padding: EdgeInsets.all(27),
                        child: IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'User Name',
                            prefixIcon: Icon(Icons.phone, color: MyMateThemes.primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ]
          ),
      ),
    );
  }
}
