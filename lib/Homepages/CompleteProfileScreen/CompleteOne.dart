import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import '../../MyMateThemes.dart';

class PageOne extends StatefulWidget {
  final VoidCallback onSave;
  final Map<String, dynamic> formData; // Add formData parameter

  PageOne({required this.onSave, required this.formData});

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  File? _imageFile;
  String? _savedImagePath;

  @override
  void initState() {
    super.initState();
    // Load the image path from formData if available
    _savedImagePath = widget.formData['profileImagePath'];
    if (_savedImagePath != null && _savedImagePath!.isNotEmpty) {
      _imageFile = File(_savedImagePath!);
    }
  }

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      )) as File?;

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
          _savedImagePath = croppedFile.path;
        });
        // Save the image path to formData
        widget.formData['profileImagePath'] = croppedFile.path;
      }
    }
  }

  void _onSave() {
    // Print the value to check if it's correctly assigned
    print('Profile Image Path: ${widget.formData['profileImagePath']}');
    widget.onSave();
  }

  void _openPopupScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width: 400,
            child: Column(
              children: [
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    _chooseImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/images/choose.svg'),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  child: SvgPicture.asset('assets/images/or.svg'),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _chooseImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/images/take.svg'),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset('assets/images/Active.svg'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Text("Update Your Profile"),
          SizedBox(height: 20),
          Stack(
            children: [
              GestureDetector(
                onTap: _openPopupScreen,
                child: _imageFile != null
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(_imageFile!),
                )
                    : SvgPicture.asset('assets/images/circle.svg'),
              ),
              Positioned(
                bottom: -1,
                left: 95,
                child: GestureDetector(
                  onTap: _openPopupScreen,
                  child: SvgPicture.asset('assets/images/edit.svg'),
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          GestureDetector(
            onTap: () {
              _chooseImage(ImageSource.gallery);
            },
            child: SvgPicture.asset('assets/images/cloud.svg'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            child: SvgPicture.asset('assets/images/orr.svg'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _chooseImage(ImageSource.camera);
            },
            child: SvgPicture.asset('assets/images/took.svg'),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _onSave, // Save and navigate to the next page
            style: CommonButtonStyle.commonButtonStyle(),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
