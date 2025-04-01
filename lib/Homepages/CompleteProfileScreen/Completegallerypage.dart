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

  Completegallerypage({
    required this.onSave,
    required this.docId,
  });

  @override
  _CompletegallerypageState createState() => _CompletegallerypageState();
}

class _CompletegallerypageState extends State<Completegallerypage> {

  List<Object?> _slots = [null, null, null];

  @override
  void initState() {
    super.initState();
    _fetchGalleryImages();
  }

  Future<void> _fetchGalleryImages() async {
    final url = Uri.parse(
      "https://backend.graycorp.io:9000/mymate/api/v1/getClientDataByDocId?docId=${widget.docId}",
    );

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<String> galleryImages = List<String>.from(
          data['profileImages']?['gallery_image_urls'] ?? [],
        );

        _slots = [null, null, null];

        for (int i = 0; i < galleryImages.length && i < 3; i++) {
          _slots[i] = galleryImages[i];
        }

        setState(() {});
        print("Gallery images fetched successfully.");
      } else {
        print("Failed to fetch gallery images. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching gallery images: $e");
    }
  }

  Future<void> _onConfirm() async {
    for (int i = 0; i < _slots.length; i++) {
      if (_slots[i] is File) {
        final file = _slots[i] as File;
        final thumbnailFile = await _createThumbnail(file);
        await _uploadImageToBackend(thumbnailFile);
      }
    }

    await _fetchGalleryImages();

    widget.onSave();
  }

  void _onSkip() {
    widget.onSave();
  }

  Future<File> _createThumbnail(File imageFile) async {
    final originalImage = img.decodeImage(await imageFile.readAsBytes());
    final resizedImage = img.copyResize(originalImage!, width: 150, height: 150);
    final tempDir = Directory.systemTemp;
    final thumbnailFile = File('${tempDir.path}/thumbnail_${_generateRandomFileName()}.jpg')
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return thumbnailFile;
  }

  Future<void> _uploadImageToBackend(File imageFile) async {
    String randomFileName = _generateRandomFileName() + '.jpg';
    final url = Uri.parse(
      "https://backend.graycorp.io:9000/mymate/api/v1/uploadProfileImages",
    );

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

  Future<void> _deleteImageFromBackend(String docId, String url) async {
    final apiurl = Uri.parse(
      "https://backend.graycorp.io:9000/mymate/api/v1/deleteGalleryImageByDocId?docId=$docId&url=$url",
    );

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

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();

    int filledCount = _slots.where((s) => s != null).length;
    if (filledCount >= 3) {
      _showMaxImageLimitDialog();
      return;
    }

    if (source == ImageSource.gallery) {
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles == null || pickedFiles.isEmpty) return;

      for (final pickedFile in pickedFiles) {
        filledCount = _slots.where((s) => s != null).length;
        if (filledCount >= 3) {
          _showMaxImageLimitDialog();
          break;
        }
        final cropped = await _cropImage(pickedFile.path);
        if (cropped != null) {
          int slotIndex = _slots.indexOf(null);
          if (slotIndex != -1) {
            _slots[slotIndex] = File(cropped.path);
          }
        }
      }
    } else {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      final cropped = await _cropImage(pickedFile.path);
      if (cropped != null) {
        int slotIndex = _slots.indexOf(null);
        if (slotIndex != -1) {
          _slots[slotIndex] = File(cropped.path);
        }
      }
    }

    setState(() {});
  }

  Future<CroppedFile?> _cropImage(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      compressQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
      compressFormat: ImageCompressFormat.jpg,
    );
  }

  void _showMaxImageLimitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Limit Reached'),
          content: Text('You can add a maximum of 3 images.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageSlots() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final slot = _slots[index];
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.005),
          child: SizedBox(
            width: screenWidth*0.29,
            height: screenHeight*0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: slot == null
                    ? _buildEmptySlot()
                    : _buildFilledSlot(slot, index),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEmptySlot() {
    return Container(
      decoration: BoxDecoration(
      color: MyMateThemes.backgroundColor,
        border: Border.all(
          color: Colors.grey,
          width:0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Image.asset(
            'assets/images/plus.png',
            width: 100,
            height: 110,

          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildFilledSlot(Object slot, int index) {
    Widget imageWidget = slot is String
        ? Image.network(slot, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
        : Image.file(slot as File, fit: BoxFit.cover, width: double.infinity, height: double.infinity);

    return Container(
      decoration: BoxDecoration(
        color: MyMateThemes.backgroundColor,
        border: Border.all(color: Colors.grey,width:0.5),
        borderRadius: BorderRadius.circular(12),

    ) ,
      child:Column(
      children: [
        Expanded(
          child: ClipRRect(

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: imageWidget,
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: MyMateThemes.backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: IconButton(
            icon: SvgPicture.asset('assets/images/trash.svg', width: 18, height: 18),
            onPressed: () async {
              if (slot is String) {
                await _deleteImageFromBackend(widget.docId, slot);
              }
              setState(() {
                _slots[index] = null;
              });
            },
          ),
        ),
      ],
      )
    );
  }

  Widget _buildFooterRow() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenHeight * 0.07,
          width: screenWidth* 0.435,
          child: ElevatedButton(
            onPressed: _onSkip,
            style: ElevatedButton.styleFrom(
            backgroundColor: MyMateThemes.secondaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth*0.01),
            ),
          ),
            child: Text(
              'Skip',
              style: TextStyle(color:MyMateThemes.primaryColor,fontSize: screenWidth * 0.045,fontWeight: FontWeight.normal), // Responsive font size

            ),
          ),
        ),
        SizedBox(width: screenWidth*0.03),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.435,
          child: ElevatedButton(
            onPressed: _onConfirm,
    style: ElevatedButton.styleFrom(
    backgroundColor: MyMateThemes.primaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(screenWidth*0.01),
    ),
    ),
            child: Text(
              'Confirm',
              style: TextStyle(color:Colors.white,fontSize: screenWidth * 0.045,fontWeight: FontWeight.normal), // Responsive font size

            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:screenHeight*0.05),
            Text("Upload to My Mate gallery",
              style: TextStyle(
              color: MyMateThemes.textColor,
              fontWeight: FontWeight.normal,
              fontSize: screenWidth * 0.04, // Adjust font size based on screen width
            ),),
            SizedBox(height: screenHeight*0.02),
            GestureDetector(
              onTap: () => _chooseImage(ImageSource.gallery),
              child: SvgPicture.asset('assets/images/cloud.svg'),
            ),
            SizedBox(height: screenHeight*0.025),
            GestureDetector(
              child: SvgPicture.asset('assets/images/orr.svg'),
            ),
            SizedBox(height: screenHeight*0.025),
            // Pick from camera
            GestureDetector(
              onTap: () => _chooseImage(ImageSource.camera),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(width: screenWidth * 0.18),
                  SizedBox(
                    height: screenHeight * 0.07,
                    width: screenWidth* 0.58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyMateThemes.secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth*0.01),
                        ),
                      ),
                      onPressed: () {  },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SvgPicture.asset(
                            'assets/images/takephoto.svg',height: screenHeight*0.02,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            'Take Photo',
                            style: TextStyle(color:MyMateThemes.primaryColor,fontSize: screenWidth * 0.04,fontWeight: FontWeight.normal), // Responsive font size

                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: screenHeight*0.06),
            _buildImageSlots(),
            SizedBox(height: screenHeight*0.04),
            _buildFooterRow(),
          ],
        ),
      ),
    );
  }
}
