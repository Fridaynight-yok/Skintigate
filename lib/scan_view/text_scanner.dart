import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextScanner extends StatefulWidget {
  const TextScanner({super.key});

  @override
  State<TextScanner> createState() => _TextScannerState();
}

class _TextScannerState extends State<TextScanner> {
  File? _image;
  String _text = 'No text found yet.';
  final picker = ImagePicker();

  Future<void> _getImageAndScanText() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);

    String scannedText = recognizedText.text;

    _image = imageFile;
    _text = scannedText.isNotEmpty ? scannedText : 'No text found';

    if (scannedText.isNotEmpty) {
      final data = await _getProductDetailbyGermini(scannedText);
      _text = '$data';
    }

    setState(() {});

    textRecognizer.close(); // always close the recognizer
  }

  Future<void> _getPhotoAndScanText() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);

    String scannedText = recognizedText.text;

    setState(() {
      _image = imageFile;
      _text = scannedText.isNotEmpty ? scannedText : 'No text found';
    });

    textRecognizer.close(); // always close the recognizer
  }

  Future<Map> _getProductDetailbyGermini(String text) async {
    var headers = {
      'Content-Type': 'application/json',
      'X-goog-api-key':
          'AIzaSyAuIeeSDt-8NSSHxezfozh16nLCLFV-FbQ', //เวลาสมัครใหม่ (บัญชีม้า)
    };
    var data = json.encode({
      "contents": [
        {
          "parts": [
            {
              "text":
                  ''' 
                  here is the product: [$text] Based on this skincare product and their ingredients, can you help me analyze? anything inside {}
                  is the key 
                  1. what brand is this product? {brand} 
                  2.what is the name of this product? {name} 
                  3.what are the ingredients of this products? {ingredients}
                  4.what kind of skin type is this product for? {skinmatch}
                  5. What Age is recommended to use this skincare {agematch}
                  6. Is it recommended for sensitive skin {sensitivity}
                  7. Skincare routine step {routine}
                  8. can I get a shopee link for this product {order}
                  9.can I get a rating score based on shopee {rating}
                  After knowing the name of the skincare product, please
                  include the name of that skincare product at the shopee link as the sample
                  below. Insert the name at {insert here} and make it into url
                  https://shopee.co.th/search?keyword={insert here}
                  Please give answer in Thai, can you give me in JSON format
                  with key and value.
                  ''',
            },
          ],
        },
      ],
      "generationConfig": {"response_mime_type": "application/json"},
    });
    var dio = Dio();
    var response = await dio.request(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      final data = response.data;
      String text = data['candidates'][0]['content']['parts'][0]['text'];
      final decoded = jsonDecode(text);
      print(decoded[0]);
      return decoded[0];
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Recognition')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _getImageAndScanText,
              child: Text('Upload Image and Extract Text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getPhotoAndScanText,
              child: Text('Access camera and Extract Text'),
            ),
            const SizedBox(height: 16),
            if (_image != null) Image.file(_image!),
            const SizedBox(height: 16),
            SelectableText(_text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
