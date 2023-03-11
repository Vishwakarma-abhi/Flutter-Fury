import 'dart:io';

import 'package:dtexto/CustomWidget/customAppbar.dart';
import 'package:dtexto/Screens/AddNote.dart';
import 'package:dtexto/Screens/TextPage.dart';
import 'package:dtexto/Screens/notes.dart';
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

  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const AddNotes(),
    const ScannedNotes(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        //leading
        leading: Icon(
          Icons.account_circle,
          size: 45,
        ),
        //title
        title: Text('d-Texto'),
      ),
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3)),
                  // color: Colors.red,
                  child: Image.asset('Assets/logo2.png'),
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
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(35)),
                          child: Icon(
                            Icons.camera,
                            size: 90,
                            color: Colors.white,
                          ),
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
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.file_copy,
                            size: 100,
                            color: Colors.white,
                          ),
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
                        color: Colors.blue,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                        child: Text(
                      'CONVERT',
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
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Get.to(HomeScreen());
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Get.to(() => AddNotes());
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.add_box,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Get.to(ScannedNotes());
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.notes,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
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
