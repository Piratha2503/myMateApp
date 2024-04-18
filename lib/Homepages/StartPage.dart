import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundWhite,
        body:  Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 240,
                width: 240,
                decoration: const BoxDecoration(
                  color: Color(0xFF7D67EE),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.fromLTRB(0, 250, 0, 0),

              ),

              Container(

                height: 240,
                width: 240,
                margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Aligns children vertically centered
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns children horizontally centered
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/blogo.svg', // Path to your SVG file
                    width: 64, // Set the width of the SVG image
                    height: 46, // Set the height of the SVG image
                  ),
                  Container(
                    height: 7,
                  ),
                  const Text("GRAY CORP",style: TextStyle(
                     color:  Color(0xFF333333),
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),)
                ],
              ),
              ),
            ],
          )

        )
    );
  }
}
