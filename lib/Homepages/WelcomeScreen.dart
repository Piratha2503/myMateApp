import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/RegisterPages/RegisterPage.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/Homepages/RegisterPages/CustomButton.dart';

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
      body: const WelcomeScreenBody(),
    );
  }
}

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageCarouselWidget(),
        const SizedBox(height: 25),
        FindYourSoulmate(),
        const SizedBox(height: 25),
        ReadOurPrivacyPolicy(),
        const PolicyRead(),
        TermsAndPolicies(),
        const SizedBox(height: 20),
        SizedBox(
          height: 58,
          width: 166,
          child: CustomButton(
            text: "Get Started",
            primaryColor: MyMateThemes.primaryColor,
            hoverColor: Colors.deepPurple.shade300,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget ImageCarouselWidget() {
  return Center(
    child: Container(
      height: 400,
      width: 350,
      color: Colors.white,
    ),
  );
}

Widget FindYourSoulmate() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        "Find your soulmate with",
        style: TextStyle(fontSize: 20),
      ),
      Text(
        " MyMate",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: MyMateThemes.textColor,
        ),
      ),
    ],
  );
}

Widget ReadOurPrivacyPolicy() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        "Read our",
        style: TextStyle(fontSize: 14),
      ),
      Text(
        " Privacy Policy",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MyMateThemes.textColor,
        ),
      ),
    ],
  );
}

Widget TermsAndPolicies() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Terms & Policies',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: MyMateThemes.textColor,
        ),
      ),
    ],
  );
}

class PolicyRead extends StatelessWidget {
  const PolicyRead({super.key});

  void Clicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => Clicked(context),
          child: Row(
            children: <Widget>[
              const Text("By tapping"),
              Text(
                " Get Started",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MyMateThemes.textColor,
                ),
              ),
              const Text(' you agree to our'),
            ],
          ),
        )
      ],
    );
  }
}
