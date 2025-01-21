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

class Completegallerypage extends StatefulWidget {
  final VoidCallback onSave;
  final String docId;

  Completegallerypage({required this.onSave, required this.docId});

  @override
  _CompletegallerypageState createState() => _CompletegallerypageState();
}

class _CompletegallerypageState extends State<Completegallerypage> {
  List<String?> _imageUrls = [null, null, null];

  @override
  void initState() {
    super.initState();

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

  void _chooseImage(ImageSource source) async {
    if (_imageUrls.where((url) => url != null).length >= 3) {
      // Show a pop-up message if 3 images are already uploaded
      _showMaxImageLimitDialog();
      return; // Prevent adding another image
    }


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

        // Fetch updated gallery images after upload
        await _fetchGalleryImages();
      }
    }
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
    return List.generate(10, (index) => characters[random.nextInt(characters.length)]).join();
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
        final List<String>? galleryImages = List<String>.from(data['profileImages']?['gallery_image_urls'] ?? {});

        setState(() {
          // Update the _imageUrls list with fetched data
          for (int i = 0; i < galleryImages!.length; i++) {
            if (i < 3) {
              _imageUrls[i] = galleryImages[i];
            }
          }
        });

        print("Gallery images fetched successfully.");
      } else {
        print("Failed to fetch gallery images. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching gallery images: $e");
    }
  }

  void _onSave() {
    widget.onSave();
  }

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 22),
        SizedBox(
          height: 50,
          width: 165,
          child: ElevatedButton(
            onPressed: () {
              _onSave();

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              // padding: EdgeInsets.all(10)
            ),
            child: Text(
              'Skip ',
              style: TextStyle(color:Colors.white),
            ),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50,
          width: 164,
          child: ElevatedButton(
            onPressed: () {
              _onSave();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            child: Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Text("Upload to My Mate gallery"),
          SizedBox(height: 20),
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
          if (_imageUrls.any((url) => url != null))
            _BuildImageGallery(
              imageUrls: _imageUrls,
              onDelete: (index) {
                setState(() {
                  _imageUrls[index] = null;
                });
              },
            ),
          SizedBox(height: 40),
          _buildFooterRow()

        ],
      ),
    );
  }
}



class _BuildImageGallery extends StatelessWidget {
  final List<String?> imageUrls;
  final Function(int index) onDelete;

  _BuildImageGallery({
    required this.imageUrls,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        String? displayImageUrl = imageUrls[index];

        if (displayImageUrl == null) {
          return SizedBox(width: 0); // Skip the slot
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(displayImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                IconButton(
                  onPressed: () => onDelete(index),
                  icon: Icon(Icons.delete, color: Colors.blue),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
