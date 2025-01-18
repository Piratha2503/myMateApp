import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../MyMateThemes.dart';

class PageOne extends StatefulWidget {
  final VoidCallback onSave;
  final String docId;

  PageOne({required this.onSave, required this.docId});

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  File? _imageFile;
  String? _savedImageUrl; // To store the uploaded image URL

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path); // Convert CroppedFile to File
        });

        // Upload the image to the backend
        await _uploadImageToBackend(File(croppedFile.path));
      }
    }
  }

  Future<void> _uploadImageToBackend(File imageFile) async {
    final url = Uri.parse(
        "https://backend.graycorp.io:9000/mymate/api/v1/uploadProfileImages");

    try {
      var request = http.MultipartRequest('PUT', url)
        ..fields['docId'] = widget.docId
        ..files.add(await http.MultipartFile.fromPath(
          'profile_Image',
          imageFile.path,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final uploadedUrl = responseBody;

        setState(() {
          _savedImageUrl = uploadedUrl;
        });

        print("Image uploaded successfully: $uploadedUrl");
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void _onSave() {
    // Log the image URL to confirm upload
    print('Saved Image URL: $_savedImageUrl');
    print(widget.docId);

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
                child: _savedImageUrl != null
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_savedImageUrl!),
                )
                    : _imageFile != null
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
