
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/MyMateThemes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyMateThemes.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyMateThemes.backgroundColor,
        ),
        body: WelcomeScreenBody()
    );
  }
}

Widget WelcomeScreenBody(){
  return Column(
    children: <Widget>[
      ImageCarouselWidget(),
      Container(height: 25,),
      FindYourSoulmate(),
      Container( height: 25,),
      ReadOurPrivacyPolicy(),
      PolicyRead(),
      TermsAndPolicies(),
      Container( height: 20, ),
      GetStartButton(),
    ],
  );
}

Widget ImageCarouselWidget(){
  return Center(
    child: Container(
      height: 400,
      width: 350,
      color: Colors.white,
    ),
  );
}

Widget FindYourSoulmate(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Find your soulmate with",
        style: TextStyle( fontSize: 20,),
      ),
      Text(
        " MyMate",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyMateThemes.textColor),
      )
    ],
  );
}

Widget ReadOurPrivacyPolicy(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Read our",
        style: TextStyle( fontSize: 14,),
      ),
      Text(
        " Privacy Policy",
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: MyMateThemes.textColor),
      ),
    ],
  );
}

Widget TermsAndPolicies(){
  return Row(
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
  );
}

class PolicyRead extends StatelessWidget{

  void Clicked(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  const PolicyRead({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(

          onTap: (){Clicked(context);},
          child: Row(
            children: <Widget>[
              Text("By tapping"),
              Text(
                "Get Started",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: MyMateThemes.textColor),
              ),
              Text(' you agree to our'),
            ],
          ),
        )
      ],
    );
  }
}

class GetStartButton extends StatelessWidget{
  void Clicked(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
  const GetStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 58,
          width: 166,
          child: ElevatedButton(
            onPressed: (){
              Clicked(context);
            },
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                backgroundColor: MaterialStatePropertyAll(MyMateThemes.primaryColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
            child: Text( "Get Started", style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }


}