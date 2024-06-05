import 'package:flutter/material.dart';
import 'package:mymateapp/MyMateThemes.dart';

class ClosableContainer extends StatefulWidget {
  final TextEditingController controller;
  final int index;
  final Function(int) onClose;
  final BuildContext parentContext;

  ClosableContainer({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyMateThemes.secondaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: 346,
                height: 65, // Increased height to accommodate TextField
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: widget.controller,
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: 'Enter text',
                      counterText:
                          characterCount <= 10 ? '$characterCount/10' : '',
                    ),
                    onChanged: (text) {
                      setState(() {
                        characterCount = text.length;
                        error = characterCount > 10
                            ? 'Character limit exceeded'
                            : '';
                        if (characterCount > 10) {
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
}
