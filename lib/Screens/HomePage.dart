import 'dart:io';

import 'package:dtexto/CustomWidget/customAppbar.dart';
import 'package:dtexto/Screens/TextPage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  late final InputImage inputImage;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.red,
                ),
              if (imageFile != null)
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    height: 300,
                    width: 300,
                    child: Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.cover,
                    )),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => getCameraImage(),
                        child: Icon(
                          Icons.camera,
                          size: 100,
                          color: Colors.red,
                        ),
                      ),
                      Text('Camera',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => getGalleryImage(),
                        child: Icon(
                          Icons.file_copy,
                          size: 100,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(ViewText(text: scannedText));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                        child: Text(
                      'VIEW',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getGalleryImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        _scanImage(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Error occured while Scanning";
    }
  }

  void getCameraImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        _scanImage(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Error occured while Scanning";
    }
  }

  Future<void> _scanImage(XFile image) async {
    final navigator = Navigator.of(context);

    try {
      final file = File(image.path);

      final inputImage = InputImage.fromFile(file);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      String text = recognizedText.text;

      scannedText = text;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
