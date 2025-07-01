import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:outlined_text/outlined_text.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _recognizedText = "";

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _imageFile = file;
        _recognizedText = "";
      });

      await _readTextFromImage(file);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Text scanned successfully")));
    } else {
      print("No image selected.");
    }
  }

  Future<void> _readTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      _recognizedText = recognizedText.text;
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/scan_page_.png",
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: OutlinedText(
                        text: Text(
                          "เลือก 1 วิธี\nเพื่อสแกนส่วนผสม",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(32, 76, 62, 1),
                            fontSize: 22,
                          ),
                        ),
                        strokes: [
                          OutlinedTextStroke(color: Colors.white, width: 1.5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "1.ก็อปปี้วางส่วนผสม ",
                    style: TextStyle(
                      color: Color.fromRGBO(32, 76, 62, 1),
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "วางส่วนผสมที่นี่",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "2. ถ่ายรูปส่วนผสมหลังกล่อง",
                    style: TextStyle(
                      color: Color.fromRGBO(32, 76, 62, 1),
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Image preview
                  if (_imageFile != null)
                    Container(
                      width: 300,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(_imageFile!, fit: BoxFit.contain),
                      ),
                    ),

                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                    ),
                    child: SizedBox(
                      width: 50,
                      height: 40,
                      child: Center(
                        child: Text(
                          "อัพรูป",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Display recognized text
                  if (_recognizedText != null && _recognizedText!.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "ผลลัพธ์จากรูปภาพ:\n$_recognizedText",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
