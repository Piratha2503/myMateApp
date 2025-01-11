import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymateapp/ChartPages/ChartInputPageWidgets.dart';
import 'package:mymateapp/ChartPages/DateTimePicker.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

class ChartInputPage extends StatefulWidget {
  const ChartInputPage({super.key});

  @override
  State<ChartInputPage> createState() => _ChartInputPageState();
}

class _ChartInputPageState extends State<ChartInputPage> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Date & Time',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Please select a date and time:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ScrollDateTimePicker(
                style: DateTimePickerStyle(
                  activeDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1)
                  ),
               activeStyle: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: 20,
               )
                ),
                centerWidget: DateTimePickerCenterWidget(

                ),
                itemExtent: 50,
                visibleItem: 3,
                // Makes the picker items larger for better visuals
                dateOption: DateTimePickerOption(

                  dateFormat: DateFormat('yyyy,MMM,d'),
                  // Enhanced format
                  minDate: DateTime(1940),
                  maxDate: DateTime(2099),
                ),
                onChange: (DateTime datetime) {
                  setState(() {
                    selectedDateTime = datetime;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Date & Time:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              DateFormat('EEE, MMM d, yyyy - hh:mm a').format(selectedDateTime),
              style: TextStyle(fontSize: 18, color: Colors.indigo),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'You selected: ${DateFormat(
                            'EEE, MMM d, yyyy - hh:mm a').format(
                            selectedDateTime)}'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
