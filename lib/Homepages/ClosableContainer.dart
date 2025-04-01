import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ClosableContainer extends StatefulWidget {
  final TextEditingController controller;
  final int index;
  final Function(int) onClose;
  final BuildContext parentContext;


  const ClosableContainer({super.key,
    required this.controller,
    required this.index,
    required this.onClose,
    required this.parentContext, // Pass context from parent widget
  });

  @override
  _ClosableContainerState createState() => _ClosableContainerState();
}

class _ClosableContainerState extends State<ClosableContainer> {
  int characterCount = 0;
  String error = '';

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Character Limit Exceeded"),
          content: Text("You can only enter a maximum of 10 characters."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(

                      decoration: BoxDecoration(

                        border: Border.all(
                          color: MyMateThemes.textColor.withOpacity(0.2),
                          width: width*0.003,
                        ),
                        borderRadius: BorderRadius.circular(width*0.02),
                      ),
                      width: width*0.99,
                      height: 65, // Increased height to accommodate TextField

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: TextField(
                          style: TextStyle(color: MyMateThemes.textColor,fontWeight: FontWeight.normal,fontSize: width*0.045),
                          controller: widget.controller,
                          maxLength: 20,
                          decoration: InputDecoration(
                            border: InputBorder.none,

                           // hintText: 'Enter text',
                            counterText:
                            characterCount <= 20 ? '$characterCount/20' : '',
                          ),
                          onChanged: (text) {
                            setState(() {
                              characterCount = text.length;
                              error = characterCount > 20
                                  ? 'Character limit exceeded'
                                  : '';
                              if (characterCount > 20) {
                                _showAlertDialog(context);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          widget.onClose(widget.index); // Call onClose directly
                        },
                      ),
                    ),
                  ],
                ),
                if (error.isNotEmpty)
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );
        }
    );
  }
}