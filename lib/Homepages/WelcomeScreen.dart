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
    return  LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return Column(
          children: <Widget>[
            SizedBox(height: height*0.08),
            ImageCarouselWidget(),
            SizedBox(height: height*0.02),
            FindYourSoulmate(),
            SizedBox(height: height*0.04),
            ReadOurPrivacyPolicy(),
            PolicyRead(),
            TermsAndPolicies(),
            SizedBox(height: height*0.02),
            GetStartButton(width,height),
            SizedBox(height:height*0.03),
            Text(
              " Copyright @ 2025 Gray Corp (Pvt) Ltd",
              style: TextStyle(
                fontSize: width*0.026,
                fontWeight: FontWeight.normal,
                color: MyMateThemes.textColor,
                letterSpacing: 0.5

              ),
            ),
          ],
        );
      }
    );
  }

  Widget ImageCarouselWidget() {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return Center(
          child: Container(
            height:  constraints.maxWidth* 1.25,
            width:  constraints.maxWidth*0.93,
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
                            borderRadius: BorderRadius.circular(width*0.01)),
                       // elevation: 5,
                        margin: EdgeInsets.all( width*0.04),
                        child: Center(
                          child: Padding(
                            padding:  EdgeInsets.all(width*0.06),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration:  Duration(milliseconds: 300),
                      margin:  EdgeInsets.symmetric(horizontal: 5),
                      height: width *0.02,
                      width: width*0.02,
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
    );
  }
}

Widget FindYourSoulmate() {
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Find your soulmate with",
            style: TextStyle(
              color: MyMateThemes.textColor,
              fontSize: width*0.042,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.8

            ),
          ),
          Text(
            " MyMate",
            style: TextStyle(
              fontSize:  width*0.042,
              fontWeight: FontWeight.w700,
              color: MyMateThemes.primaryColor,
              letterSpacing: 0.8

            ),
          ),
        ],
      );
    }
  );
}

Widget ReadOurPrivacyPolicy() {
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            "Read our",
            style: TextStyle(
              fontSize: width*0.033,
              color: MyMateThemes.textColor,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5

            ),
          ),
          Text(
            " Privacy Policy",
            style: TextStyle(
                fontSize: width*0.033,
                fontWeight: FontWeight.w500,
                color: MyMateThemes.primaryColor,
                letterSpacing: 0.5

            ),
          ),
        ],
      );
    }
  );
}

Widget TermsAndPolicies() {
  return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Terms & Policies',
            style: TextStyle(
                fontSize: width*0.033,
                fontWeight: FontWeight.w500,
                color: MyMateThemes.primaryColor,
                letterSpacing: 0.5

            ),
          ),
        ],
      );
    }
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
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Clicked(context);
              },
              child: Row(
                children: <Widget>[
                   Text("By tapping",
                    style: TextStyle(
                      fontSize: width*0.033,
                      fontWeight: FontWeight.normal,
                      color: MyMateThemes.textColor,
                        letterSpacing: 0.5
                    ),),
                  Text(
                    ' "Get Started"',
                    style: TextStyle(
                        fontSize:width*0.033,
                        fontWeight: FontWeight.w500,
                        color: MyMateThemes.primaryColor,
                        letterSpacing: 0.5
                    ),
                  ),
                   Text(' you agree to our',
                      style: TextStyle(
                      fontSize: width*0.033,
                      fontWeight: FontWeight.normal,
                      color: MyMateThemes.textColor,
                          letterSpacing: 0.5
                      )),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}

class GetStartButton extends StatelessWidget {
  final double width;
  final double height;

  const GetStartButton(this.width, this.height, {super.key});

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
              height: height*0.07,
              width: width*0.45,
              child: ElevatedButton(
                onPressed: () {
                  Clicked(context);
                },
                style: CommonButtonStyle.commonButtonStyle(),

                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: width*0.04),
                ),
              ),
            )
          ],
        );

  }
}
