import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class ChartInputPage extends StatefulWidget {
  const ChartInputPage({super.key});

  @override
  State<ChartInputPage> createState() => _ChartInputPageState();
}

class _ChartInputPageState extends State<ChartInputPage> {
  void onPressed() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyMateThemes.backgroundColor,
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            width: 400,
            child: ContainerColumn(),
          ),
          const SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 50,
            width: 375,
            child: PlaceSearch(),
          ),
          const SizedBox( height: 2, ),

          SizedBox( height: 50, width: 375,
            child: DOB(),
          ),
          SizedBox( height: 50, width: 375,
            child: TOB(),
          ),
          SizedBox( height: 50, width: 375,
            child: Rasi(),
          ),
          SizedBox( height: 50, width: 375,
            child: Nadchathira(),
          ),

        ],
      ),
    );
  }
}

Widget DOB() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: const TextField(
      decoration: InputDecoration(
          suffix: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.calendar_month_rounded),
          Icon(Icons.arrow_drop_down_sharp),
        ],
      )),
    ),
  );
}

Widget TOB() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: const TextField(
      decoration: InputDecoration(
          suffix: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.access_time),
          Icon(Icons.arrow_drop_down_sharp),
        ],
      )),
    ),
  );
}

Widget Rasi() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: const TextField(
      decoration: InputDecoration(
          hintText: "Rasi",
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.black87,
          ),
          suffix: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.arrow_drop_down_sharp),
            ],
          )),
    ),
  );
}

Widget Nadchathira() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: const TextField(
      decoration: InputDecoration(
          hintText: "Nadchathira",
          suffix: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.arrow_drop_down_sharp),
            ],
          )),
    ),
  );
}

Widget PlaceSearch() {
  TextEditingController controller = TextEditingController();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: GooglePlaceAutoCompleteTextField(
      boxDecoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.zero),
          border: Border(
            bottom: BorderSide(style: BorderStyle.solid),
          )),
      textEditingController: controller,
      googleAPIKey: "AIzaSyAoxfRZPpxjemh98ITN_FnpSElHr7kmNYs",
      inputDecoration: const InputDecoration(
        hintText: "Place of Birth (City)",
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        suffixIcon: Icon(Icons.arrow_drop_down),
      ),

      debounceTime: 400,
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        print("placeDetails" + prediction.lat.toString());
      },

      itemClick: (Prediction prediction) {
        controller.text = prediction.description ?? "";
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description?.length ?? 0));
      },
      seperatedBuilder: Divider(),
      containerHorizontalPadding: 10,

      // OPTIONAL// If you want to customize list view item builder
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 7,
              ),
              Expanded(child: Text("${prediction.description ?? ""}"))
            ],
          ),
        );
      },

      isCrossBtnShown: true,

      // default 600 ms ,
    ),
  );
}

Widget ContainerColumn() {
  return const Column(
    children: [
      Text(
        "Enter birth details",
        style: TextStyle(
            fontSize: MyMateThemes.subHeadFontSize,
            color: MyMateThemes.textGray),
      ),
      Text(
        "to calculate Astrology chart ",
        style: TextStyle(
            fontSize: MyMateThemes.subHeadFontSize,
            color: MyMateThemes.textColor),
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(height: 10,),

      Text(
        "Make sure this number can receive SMS.",
        style: TextStyle(fontSize: 14),
      ),
      Text(
        "You will receive your activation code",
        style: TextStyle(fontSize: 14),
      ),
      Text(
        "through it.",
        style: TextStyle(fontSize: 14),
      ),
    ],
  );
}
