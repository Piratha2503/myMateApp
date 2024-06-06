import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeCheck extends StatefulWidget {
  const DateTimeCheck({super.key});

  @override
  State<StatefulWidget> createState() => _DateTimeCheckState();

  }

  class _DateTimeCheckState extends State<DateTimeCheck>{

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
