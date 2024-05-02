import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DateTimeCheck());
}

class DateTimeCheck extends StatelessWidget {
  const DateTimeCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cupertino Date Picker Example'),
        ),
        body: Center(
          child: CupertinoButton(
            child: const Text('Show Date Picker'),
            color: Colors.lightGreen,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
            },
          ),
        ),
      ),
    );
  }
}
