import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymateapp/MyMateThemes.dart';

import '../ManagePages/HelpPage.dart';

class SingleHelpPage extends StatefulWidget {
  final String docId;
  const SingleHelpPage({super.key,required this.docId});

  @override
  _SingleHelpPageState createState() => _SingleHelpPageState();
}

class _SingleHelpPageState extends State<SingleHelpPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures the keyboard does not overlap content
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismiss the keyboard when tapping outside
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Helppage(docId: widget.docId,)),
                                );
                              },
                              child: SvgPicture.asset(
                                  'assets/images/chevron-left.svg'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width: 185),
                            SvgPicture.asset('assets/images/headphone.svg'),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 115),
                            Container(
                              height: 45,
                              width: 158,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: MyMateThemes.secondaryColor,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'My Mate',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: MyMateThemes.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width:30),
                            SvgPicture.asset('assets/images/headphone.svg'),
                            const SizedBox(width: 5),
                            Container(
                              height: 70,
                              width: 280,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: MyMateThemes.secondaryColor,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Hi User, I'm My Mate, Your automated "
                                      "virtual assistant. How may I help you today?",
                                  style: const TextStyle(
                                    color: MyMateThemes.textColor,
                                    fontSize: 12,
                                    letterSpacing: 0.9,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 5.0),

                          decoration: BoxDecoration(
                            color: MyMateThemes.secondaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child:
                            Padding(padding: const EdgeInsets.only(left: 25.0),
                              child:   TextField(
                                focusNode: _focusNode,
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText:  "Keep your question short & simple",
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () {
                                      print(_controller.text);
                                      _controller.clear();
                                    },
                                  ),
                                ),
                              ),

                           )

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
