import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymateapp/MyMateThemes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void Clicked() {
    print("Hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyMateThemes.backgroundColor,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: 400,
              width: 350,
              color: Colors.white,
            ),
          ),
          Container(
            height: 25,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Find your soulmate with",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                " MyMate",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyMateThemes.textColor),
              )
            ],
          ),
          Container(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Read our",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                " Privacy Policy",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyMateThemes.textColor),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            GestureDetector(
                onTap: Clicked,
                child: const Row(
                  children: <Widget>[
                    Text("By tapping"),
                    Text(
                      ' "Get Started" ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyMateThemes.textColor),
                    ),
                    Text('you agree to our'),
                  ],
                ))
          ]),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Terms & Policies',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyMateThemes.textColor),
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 58,
                width: 166,
                child: ElevatedButton(
                  onPressed: Clicked,
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF19434E)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18),
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
