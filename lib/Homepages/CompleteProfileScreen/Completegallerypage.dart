import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
  List<File> _selectedImages = [];
 bool _isLoading = false;

  void _showMaxImageLimitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Limit Reached'),
          content: Text('You can add up to 3 images.'),
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

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0), // Square crop
      compressQuality: 100, // Best quality
      maxHeight: 1000,
      maxWidth: 1000,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: MyMateThemes.primaryColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true, // Locks aspect ratio to 1:1
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true, // Locks aspect ratio to 1:1
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }


  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    List<XFile>? pickedImages;

    try {
      if (source == ImageSource.gallery) {
        pickedImages = await picker.pickMultiImage();
      } else {
        final pickedImage = await picker.pickImage(source: source);
        if (pickedImage != null) pickedImages = [pickedImage];
      }

      if (pickedImages != null && pickedImages.isNotEmpty) {
        if (pickedImages.length + _selectedImages.length > 3) {
          _showMaxImageLimitDialog();
          return;
        }

        // Process images sequentially
        for (final image in pickedImages) {
          final croppedFile = await _cropImage(File(image.path));
          if (croppedFile != null) {
            final resizedFile = await _resizeImage(croppedFile);
            setState(() {
              _selectedImages.add(resizedFile);
            });
          }
        }
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<File> _resizeImage(File imageFile) async {
    final originalImage = img.decodeImage(await imageFile.readAsBytes());
    final resizedImage = img.copyResize(originalImage!, width: 150, height: 150);

    // Generate unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final tempDir = Directory.systemTemp;
    final resizedFile = File('${tempDir.path}/resized_image_$timestamp.jpg')
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return resizedFile;
  }

  Future<void> _uploadImagesToBackend() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      for (File imageFile in _selectedImages) {
        String randomFileName = _generateRandomFileName() + '.jpg';
        final url = Uri.parse(
            "https://backend.graycorp.io:9000/mymate/api/v1/uploadProfileImages");

        var request = http.MultipartRequest('PUT', url)
          ..fields['docId'] = widget.docId
          ..files.add(await http.MultipartFile.fromPath(
            'gallery_image',
            imageFile.path,
            filename: randomFileName,
          ));

        final response = await request.send();
        if (response.statusCode != 200) {
          throw Exception('Failed to upload image: ${response.statusCode}');
        }
      }
    } catch (e) {
      print("Error uploading images: $e");
      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading images: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // End loading
        _selectedImages.clear();
      });
    }
  }


  String _generateRandomFileName() {
    final random = Random();
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(10, (index) => characters[random.nextInt(characters.length)]).join();
  }

  void _onConfirm() async {
    await _uploadImagesToBackend();
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
            onPressed: widget.onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            child: Text('Skip', style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50,
          width: 164,
          child: ElevatedButton(
            onPressed: _onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyMateThemes.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : const Text('Confirm', style: TextStyle(color: Colors.white)),
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
            onTap: () => _chooseImage(ImageSource.gallery),
            child: SvgPicture.asset('assets/images/cloud.svg'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            child: SvgPicture.asset('assets/images/orr.svg'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => _chooseImage(ImageSource.camera),
            child: SvgPicture.asset('assets/images/took.svg'),
          ),
          SizedBox(height: 40),
          if (_selectedImages.isNotEmpty)
            _BuildImageGallery(
              selectedImages: _selectedImages,
              onDelete: (index) {
                setState(() {
                  _selectedImages.removeAt(index);
                });
              },
            ),
          SizedBox(height: 40),
          _buildFooterRow(),
        ],
      ),
    );
  }
}

class _BuildImageGallery extends StatelessWidget {
  final List<File> selectedImages;
  final Function(int index) onDelete;

  _BuildImageGallery({required this.selectedImages, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(selectedImages.length, (index) {
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
                        image: FileImage(selectedImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => onDelete(index),
                  child: Image.asset(
                    'assets/images/trash.png',
                    width: 24,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}