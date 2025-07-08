import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outlined_text/outlined_text.dart';
import 'package:skintigate/scan_view/upload_image.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final picker = ImagePicker();
  final controller = TextEditingController();

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
                  8. can I get a shopee link for this product {orderlink}
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

    try {
      var response = await dio.request(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        String text = data['candidates'][0]['content']['parts'][0]['text'];
        final decoded = jsonDecode(text);
        return decoded[0];
      } else {
        return {};
      }
    } catch (_) {
      return {};
    }
  }

  Future<void> getImageAndScanText(bool isGallery) async {
    final pickedFile = await picker.pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
    );
    if (pickedFile == null) return;
    _showLoading();

    final imageFile = File(pickedFile.path);
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);

    String scannedText = recognizedText.text;

    if (scannedText.isNotEmpty) {
      Map data = await _getProductDetailbyGermini(scannedText);
      _cancelLoading();
      if (data.isEmpty) {
        _showAlertDialog(context);
      } else {
        _showLoading();
        String url = await UploadImg().uploadImage(pickedFile.path);
        data['image'] = url;
        _cancelLoading();
        Get.toNamed("/product", arguments: data);
      }
    } else {
      _cancelLoading();
    }

    setState(() {});
    textRecognizer.close(); // always close the recognizer
  }

  /// Dialog UI
  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('เกิดข้อผิดพลาด'),
        content: const Text('ไม่สามารถสแกนได้ขณะนี้ กรุณาลองใหม่อีกครั้ง'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('รูปภาพ'),
          message: const Text('โปรดเลือกช่องทางสำหรับการแนบรูปภาพ'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                getImageAndScanText(false);
              },
              child: const Text('กล้อง'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                getImageAndScanText(true);
              },
              child: const Text('แกลเลอรี่'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  void _showLoading() {
    Get.dialog(Center(child: CircularProgressIndicator(color: Colors.white)));
  }

  void _cancelLoading() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/scan_page_.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
        ),
        Container(
          height: double.infinity,
          color: Color.fromARGB(111, 161, 160, 160),
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent),
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: OutlinedText(
                          text: Text(
                            "เลือก 1 วิธี\nเพื่อสแกนสินค้าหรือส่วนผสม",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.athiti(
                              fontSize: 24,
                              color: Color.fromRGBO(35, 96, 77, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          strokes: [
                            OutlinedTextStroke(color: Colors.white, width: 2),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "1.พิมพ์ชื่อสินค้าหรือส่วนผสม ",
                      style: GoogleFonts.athiti(
                        fontSize: 22,
                        color: Color.fromRGBO(35, 96, 77, 1),
                        fontWeight: FontWeight.w500,
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
                          controller: controller,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "พิมพ์ที่นี่",
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    if (controller.text.isNotEmpty) ...[
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          _showLoading();
                          Map data = await _getProductDetailbyGermini(
                            controller.text,
                          );
                          if (data.isEmpty) {
                            _showAlertDialog(context);
                          } else {
                            _cancelLoading();
                            data['image'] =
                                'https://res.cloudinary.com/dtflazdw8/image/upload/v1751545476/bznw8m96gactag2bov0n.png';
                            Get.toNamed("/product", arguments: data);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                        ),
                        child: SizedBox(
                          width: 50,
                          height: 40,
                          child: Center(
                            child: Text(
                              "ค้นหา",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "2. ถ่ายรูปสินค้าหรือส่วนผสมหลังกล่อง",
                        style: GoogleFonts.athiti(
                          fontSize: 22,
                          color: Color.fromRGBO(35, 96, 77, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus(); //แก้เพิ่ม
                        _showActionSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                      ),
                      child: SizedBox(
                        width: 80,
                        height: 40,
                        child: Center(
                          child: Text(
                            "อัพโหลดรูป",
                            style: GoogleFonts.athiti(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
