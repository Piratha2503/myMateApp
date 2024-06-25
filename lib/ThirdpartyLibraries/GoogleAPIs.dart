import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class GooglePlacesAPI extends StatefulWidget{
  GooglePlacesAPI(this.hint,{super.key});
  String hint;

  @override
  State<GooglePlacesAPI> createState() => _GooglePlacesAPIState();
}

class _GooglePlacesAPIState extends State<GooglePlacesAPI>{

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: 300,
      child: GooglePlaceAutoCompleteTextField(
        countries: ["LK"],
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        boxDecoration: BoxDecoration(
            border: Border(top: BorderSide.none,bottom: BorderSide(width: 1.0))
        ),
        textEditingController: controller,
        googleAPIKey: "AIzaSyAoxfRZPpxjemh98ITN_FnpSElHr7kmNYs",
        inputDecoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("placeDetails${prediction.lat}");
        },
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(),
        containerHorizontalPadding: 10,
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 7),
                Expanded(
                    child: Text(
                      prediction.description ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    )
                ),
              ],
            ),
          );
        },
        isCrossBtnShown: true,
      ),

    );
  }
}