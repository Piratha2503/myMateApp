import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';


Widget ContainerColumn() {
  return SizedBox(
    height: 150,
    width: 400,
    child: Column(
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
        SizedBox( height: 10, ),
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
    ),
  );
}

Widget PlaceSearch() {
  TextEditingController controller = TextEditingController();
  return SizedBox(
    height: 50,
    width: 375,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.zero),
          border: Border(
            bottom: BorderSide(style: BorderStyle.solid),
          ),
        ),
        textEditingController: controller,
        googleAPIKey: "AIzaSyDXYDH7RzCBslFlJHbfGq8Msms3yd5h7Hg",
        inputDecoration: InputDecoration(
          hintText: "Place of Birth (City)",
          border: InputBorder.none,
          enabledBorder: InputBorder.none, suffixIcon: Icon(Icons.arrow_drop_down),
        ),
        countries: ["LK"],

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
                SizedBox( width: 7, ),
                Expanded(child: Text(prediction.description ?? ""))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    ),
  );
}

Widget DOB() {
  FormGroup buildForm() => fb.group({
    'date': FormControl<DateTime>(value: DateTime.now()),
    'time': FormControl<DateTime>(value: DateTime.now()),
    'dateTime': FormControl<DateTime>(value: DateTime.now()),
    'dateTimeNullable': FormControl<DateTime>(value: null),
  });
  return SizedBox( height: 50, width: 375,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: ReactiveFormBuilder(
          form: buildForm,
          builder: (context, form, child) {
            return Column(
              children: [
                const SizedBox(height: 8),
                ReactiveDateTimePicker(
                  formControlName: 'date',
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    helperText: '',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 8),
                ReactiveDateTimePicker(
                  formControlName: 'time',
                  type: ReactiveDatePickerFieldType.time,
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder(),
                    helperText: '',
                    suffixIcon: Icon(Icons.watch_later_outlined),
                  ),
                ),
                const SizedBox(height: 8),
                ReactiveDateTimePicker(
                  formControlName: 'dateTime',
                  type: ReactiveDatePickerFieldType.dateTime,
                  decoration: const InputDecoration(
                    labelText: 'Date & Time',
                    border: OutlineInputBorder(),
                    helperText: '',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 8),
                ReactiveDateTimePicker(
                  formControlName: 'dateTimeNullable',
                  type: ReactiveDatePickerFieldType.dateTime,
                  decoration: const InputDecoration(
                    labelText: 'Date & Time',
                    hintText: 'hintText',
                    border: OutlineInputBorder(),
                    helperText: 'helperText',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    if (form.valid) {
                      // ignore: avoid_print
                      print(form.value);
                    } else {
                      form.markAllAsTouched();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
  );
}

Widget TOB() {
  return SizedBox(
    height: 50, width: 375,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: const TextField(
        decoration: InputDecoration(
          suffix: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.access_time),
              Icon(Icons.arrow_drop_down_sharp),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget Rasi() {
  return SizedBox(
    height: 50,
    width: 375,
    child: Container(
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
    ),
  );
}

Widget Nadchathira() {
  return SizedBox(
    height: 50,
    width: 375,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Nadchathira",
          suffix: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.arrow_drop_down_sharp),
            ],
          ),
        ),
      ),
    ),
  );
}