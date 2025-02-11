import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
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
  String? _savedImageUrl;

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

        File thumbnailFile = await _createThumbnail(File(croppedFile.path));

        setState(() {
          _imageFile = thumbnailFile;
        });


      }
    }
  }

  void _onSave() async {
    if (_imageFile != null) {
      await _uploadImageToBackend(_imageFile!);
    } else {
      print("No image selected to save.");
    }

    print('Saved Image URL: $_savedImageUrl');
    print(widget.docId);

    widget.onSave();
  }

  Future<File> _createThumbnail(File imageFile) async {

    final originalImage = img.decodeImage(await imageFile.readAsBytes());


    final resizedImage = img.copyResize(originalImage!, width: 150, height: 150);


    final tempDir = Directory.systemTemp;
    final thumbnailFile = File('${tempDir.path}/thumbnail.jpg')
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return thumbnailFile;
  }


  Future<void> _uploadImageToBackend(File imageFile) async {
    String randomFileName = _generateRandomFileName() + '.jpg';

    final fileSize = await imageFile.length();
    print("Image File Size: ${fileSize / 1024} KB");


    final imageBytes = await imageFile.readAsBytes();
    final decodedImage = img.decodeImage(imageBytes);
    if (decodedImage != null) {
      print("Image Resolution: ${decodedImage.width}x${decodedImage.height}");
    } else {
      print("Unable to decode image resolution.");
    }
    final url = Uri.parse(
        "https://backend.graycorp.io:9000/mymate/api/v1/uploadProfileImages");

    try {
      var request = http.MultipartRequest('PUT', url)
        ..fields['docId'] = widget.docId
        ..files.add(await http.MultipartFile.fromPath(
          'profile_Image',
          imageFile.path,
          filename: randomFileName,
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

  String _generateRandomFileName() {
    final random = Random();
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(10, (index) => characters[random.nextInt(characters.length)]).join();
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
          SizedBox(height: 40),
          Stack(
            children: [
              GestureDetector(
                // onTap: _openPopupScreen,
                // child: _savedImageUrl != null
                //     ? CircleAvatar(
                //   radius: 50,
                //   backgroundImage: NetworkImage(_savedImageUrl!),
                // )
                  child  : _imageFile != null
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(_imageFile!),
                )
                    : SvgPicture.asset('assets/images/circle.svg'),
              ),
              // Positioned(
              //   bottom: -6,
              //   left: 76,
              //   child: GestureDetector(
              //     onTap: _openPopupScreen,
              //     child: SvgPicture.asset('assets/images/edit.svg'),
              //   ),
              // ),
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
            onPressed: _onSave,
            style: CommonButtonStyle.commonButtonStyle(),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
