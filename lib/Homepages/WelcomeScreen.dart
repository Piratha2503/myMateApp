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
  int currentStepIndex = 0; // Track the current step in the carousel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WelcomeScreenBody(),
    );
  }

  Widget WelcomeScreenBody() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 80),
        ImageCarouselWidget(),
        const SizedBox(height: 25),
        FindYourSoulmate(),
        const SizedBox(height: 25),
        ReadOurPrivacyPolicy(),
        PolicyRead(),
        TermsAndPolicies(),
        const SizedBox(height: 20),
        GetStartButton(),
        const SizedBox(height: 30),
        Text(
          " Copyright @ 2025 Gray Corp (Pvt) Ltd",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: MyMateThemes.textColor,
            fontFamily: "Work Sans",
            letterSpacing: 0.6

          ),
        ),
      ],
    );
  }

  Widget ImageCarouselWidget() {
    return Center(
      child: SizedBox(
        height: 438,
        width: 345,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 4, // Define the number of pages
                onPageChanged: (index) {
                  setState(() {
                    currentStepIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Card(

                    color: MyMateThemes.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                   // elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Step ${index + 1}",
                            //   style: const TextStyle(fontSize: 18),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: 10,
                  //width: currentStepIndex == index ? 20 : 10,
                  decoration: BoxDecoration(
                    color: currentStepIndex == index
                        ? MyMateThemes.primaryColor
                        : MyMateThemes.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget FindYourSoulmate() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        "Find your soulmate with",
        style: TextStyle(
          color: MyMateThemes.textColor,
          fontSize: 20,
          fontWeight: FontWeight.normal,
          fontFamily: "Work Sans",

        ),
      ),
      Text(
        " MyMate",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: MyMateThemes.primaryColor,
          fontFamily: "Work Sans",

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
        style: TextStyle(
          fontSize: 14,
          color: MyMateThemes.textColor,
          letterSpacing: 0.8

        ),
      ),
      Text(
        " Privacy Policy",
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: MyMateThemes.primaryColor,
            letterSpacing: 0.8

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
            color: MyMateThemes.primaryColor,
            letterSpacing: 0.8

        ),
      ),
    ],
  );
}

class PolicyRead extends StatelessWidget {
  const PolicyRead({super.key});

  void Clicked(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Clicked(context);
          },
          child: Row(
            children: <Widget>[
              const Text("By tapping",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor,
                    letterSpacing: 0.8
                ),),
              Text(
                ' "Get Started"',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: MyMateThemes.primaryColor,
                    letterSpacing: 0.8
                ),
              ),
              const Text(' you agree to our',
                  style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: MyMateThemes.textColor,
                      letterSpacing: 0.8
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class GetStartButton extends StatelessWidget {
  const GetStartButton({super.key});

  void Clicked(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 58,
          width: 166,
          child: ElevatedButton(
            onPressed: () {
              Clicked(context);
            },
            style: CommonButtonStyle.commonButtonStyle(),

            child: const Text(
              "Get Started",
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
