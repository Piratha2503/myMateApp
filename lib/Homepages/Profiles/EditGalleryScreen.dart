import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart' as img;

import '../../MyMateThemes.dart';

class EditGalleryScreen extends StatefulWidget {
  final VoidCallback onSave;
  final String docId;

  EditGalleryScreen({required this.onSave, required this.docId});

  @override
  _EditGalleryScreenState createState() => _EditGalleryScreenState();
}

class _EditGalleryScreenState extends State<EditGalleryScreen> {
  List<String?> _imageUrls = [null, null, null];

  @override
  void initState() {
    super.initState();
    _fetchGalleryImages();
  }

  void _showMaxImageLimitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Limit Reached'),
          content: Text('You can add 3 images at a time.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _openPopupScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;

        return AlertDialog(
          content: SingleChildScrollView(
            child: Expanded(
              child: SizedBox(
                height: height * 0.8,
                width: width*0.3 ,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                children: [
                  GestureDetector(
                    onTap: () {
                      _chooseImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/images/choose.svg',
                      width: width * 0.25, // Scale image size dynamically
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/or.svg',
                      height: height*0.1,

                      width: width * 0.18,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  GestureDetector(
                    onTap: () {
                      _chooseImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/images/take.svg',
                      height: height*0.1,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/images/Active.svg',
                      height: height*0.1,
                     // width: width * 0.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        );
      },
    );
  }

  Future<void> _chooseImage(ImageSource source) async {


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
        await _uploadImageToBackend(thumbnailFile);
        await _fetchGalleryImages();
      }
    }
  }

  Future<File> _createThumbnail(File imageFile) async {
    final originalImage = img.decodeImage(await imageFile.readAsBytes());
    final resizedImage =
        img.copyResize(originalImage!, width: 150, height: 150);
    final tempDir = Directory.systemTemp;
    final thumbnailFile = File('${tempDir.path}/thumbnail.jpg')
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return thumbnailFile;
  }

  Future<void> _uploadImageToBackend(File imageFile) async {
    String randomFileName = _generateRandomFileName() + '.jpg';
    final url = Uri.parse(
        "https://backend.graycorp.io:9000/mymate/api/v1/uploadProfileImages");

    try {
      var request = http.MultipartRequest('PUT', url)
        ..fields['docId'] = widget.docId
        ..files.add(await http.MultipartFile.fromPath(
          'gallery_image',
          imageFile.path,
          filename: randomFileName,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        print("Image uploaded successfully.");
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
    return List.generate(
        10, (index) => characters[random.nextInt(characters.length)]).join();
  }

  Future<void> _fetchGalleryImages() async {
    final url = Uri.parse(
        "https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByDocId?docId=${widget.docId}");

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<String>? galleryImages = List<String>.from(
            data['profileImages']?['gallery_image_urls'] ?? []);

        setState(() {
          for (int i = 0; i < galleryImages!.length; i++) {
            if (i < 3) {
              _imageUrls[i] = galleryImages[i];
            }
          }
        });
        print(galleryImages);
        print("Gallery images fetched successfully.");
      } else {
        print(
            "Failed to fetch gallery images. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching gallery images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          _BuildImageGallery(
            imageUrls: _imageUrls,
            onDelete: (index) {
              setState(() {
                _imageUrls[index] = null;
              });
            },
            onAdd: (index) async {
              await _chooseImage(ImageSource.gallery);
              await _fetchGalleryImages();

            }, openPopupScreen: _openPopupScreen

          ),
        ],
      ),
    );
  }
}

class _BuildImageGallery extends StatelessWidget {
  final List<String?> imageUrls;
  final Function(int index) onDelete;
  final Function(int index) onAdd;
  final VoidCallback openPopupScreen;
  _BuildImageGallery({
    required this.imageUrls,
    required this.onDelete,
    required this.onAdd,
    required this.openPopupScreen,
  });



  Future<void> _deleteImageFromBackend(String docId, String url) async {
    final apiurl = Uri.parse(
        "https://backend.graycorp.io:9000/mymate/api/v1/deleteGalleryImageByDocId?docId=$docId&url=$url");

    try {
      final response = await http.put(
        apiurl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Image deleted successfully from backend.");
      } else {
        print("Failed to delete image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03), // Adjust padding dynamically
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          String? displayImageUrl = imageUrls[index];

          return Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: displayImageUrl != null ? 0 : 0,
              child: Container(
                width: screenWidth * 0.3, // Dynamic width
                height: screenHeight * 0.23, // Dynamic height
                decoration: BoxDecoration(
                  color: displayImageUrl != null ? Colors.white : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: displayImageUrl != null
                    ? Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.15,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(displayImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () async {
                        await _deleteImageFromBackend(
                            (context.findAncestorStateOfType<_EditGalleryScreenState>()
                            as _EditGalleryScreenState)
                                .widget
                                .docId,
                            displayImageUrl);

                        onDelete(index);
                      },
                      child: SvgPicture.asset(
                        'assets/images/trash.svg',
                      ),
                    ),
                  ],
                )
                    : GestureDetector(
                  onTap: () async {
                    openPopupScreen();
                  },
                  child: Container(
                    width: screenWidth * 0.28,
                    height: screenHeight * 0.23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Image.asset(
                          'assets/images/Group 2236.png',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
