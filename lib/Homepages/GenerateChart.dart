import 'package:flutter/material.dart';
import 'package:mymateapp/ChartPages/ChartViewPage.dart';
import 'package:mymateapp/Homepages/AnimatedPages/ChartCalculating.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/ThirdpartyLibraries/GoogleAPIs.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:scroll_time_picker/scroll_time_picker.dart';

class GenerateChart extends StatefulWidget {
  const GenerateChart({super.key});
  @override
  State<GenerateChart> createState() => _GenerateChartState();
}

class _GenerateChartState extends State<GenerateChart> {

  Future<void> _showDateModal(BuildContext context) {
    DateTime date = DateTime.now();
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){Navigator.pop(context);},
                    icon: Icon(Icons.close,size: 30,weight: 600,))
              ],
            ),
          SizedBox(
          height: 300,
          child: ScrollDatePicker(
            selectedDate: date,
            locale: Locale('en'),
            onDateTimeChanged: (DateTime value) {
              setState(() {
                date = value;
              });
            },
          ),
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          MyMateThemes.secondaryColor
                      ),
                    ),
                    onPressed: (){Navigator.pop(context);},
                    child: Text("Select")),

              ],
            ),
          ],
        );

      },
    );
  }

  Future<void> _showTimeModal(BuildContext context) {
    DateTime time = DateTime.now();
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){Navigator.pop(context);},
                    icon: Icon(Icons.close,size: 30,weight: 600,))
              ],
            ),
            SizedBox(
              height: 150,
              child: ScrollTimePicker(
                selectedTime: time,
                is12hFormat: true,
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    time = value;
                  });
                },
              ),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text("Select")),
                ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
              SizedBox( height: 10,),
               Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(height: 10),
                Text(
                  "Calculate your Astrology chart",
                  style: TextStyle(
                      fontSize: MyMateThemes.subHeadFontSize,
                      fontWeight: FontWeight.w600,
                      color: MyMateThemes.textColor),
                ),
                SizedBox(height: 15),
              ],
            ),
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  SizedBox( height: 10,),
                  GooglePlacesAPI("Place of birth (city)"),
                  SizedBox( height: 10,),
                  DateTimeSelect(true),
                  SizedBox( height: 10,),
                  DateTimeSelect(false),
                ],
              ),
            ),
            SizedBox( height: 50,),
            SizedBox(
              height: 58,
              width: 166,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>ChartCalculating()));},
                style: CommonButtonStyle.commonButtonStyle(),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: MyMateThemes.buttonFontSize),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget DateTimeSelect(bool date){
    return GestureDetector(
      onTap: ()=> date ? _showDateModal(context) : _showTimeModal(context),
      child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    width: 1,
                  )
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              top: 5,
            ),
            child: Text(date ? "Date of Birth" : "Time of Birth",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600
              ),),
          )
      ),

    );
  }

  }




